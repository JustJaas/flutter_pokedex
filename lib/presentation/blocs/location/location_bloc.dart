import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_routes/data/http_services.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;
  List<LatLng> tempLocation = [];
  LocationBloc() : super(const LocationState()) {
    on<NewLocationEvent>((event, emit) {
      print("event.showRoute");
      print(state.enableRoute);

      print("state.tempLocation");
      print(state.tempLocation);
      print("state.locationHistory");
      print(state.locationHistory);

      if (state.enableRoute) {
        tempLocation = [...state.locationHistory, event.newLocation];
      } else {
        tempLocation = [];
      }

      // final List<LatLng> tempLocationHistory = [];
      emit(state.copyWith(
        lastKnowLocation: event.newLocation,
        // locationHistory: (state.enableRoute)
        //     ? [...state.locationHistory, event.newLocation]
        //     : [],
        locationHistory: tempLocation,
        // locationHistory: [...state.tempLocation!, event.newLocation],
      ));
    });

    on<StartRoute>((event, emit) {
      if (state.enableRoute) {
        final locationData = state.locationHistory;
        List<Map<String, dynamic>> listLocations = locationData.map((latLng) {
          return {
            'latitude': latLng.latitude,
            'longitude': latLng.longitude,
          };
        }).toList();

        sendData(listLocations);
        print("SUECOS");
      }
      emit(state.copyWith(enableRoute: !state.enableRoute));
    });
  }

  Future sendData(listLocations) async {
    print("SendData(listLocations)");
    final data = await postDataLocations(listLocations);
    print(data);

    if (data) {
      return data;
    }
  }

  Future getCurrentPosition(showRoute) async {
    final position = await Geolocator.getCurrentPosition();

    add(NewLocationEvent(
      LatLng(
        position.latitude,
        position.longitude,
      ),
      showRoute,
    ));

    print("Position: $position");
  }

  void startFollow(showRoute) {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(NewLocationEvent(
        LatLng(
          position.latitude,
          position.longitude,
        ),
        showRoute,
      ));
    });
  }
}
