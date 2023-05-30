import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_routes/data/http_services.dart';
import 'package:maps_routes/presentation/blocs/location/location_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? mapController;
  StreamSubscription<LocationState>? locationStateSubscription;
  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    on<MapInitEvent>(initMap);

    locationStateSubscription = locationBloc.stream.listen((localtionState) {
      if (localtionState.lastKnowLocation != null) {
        if (localtionState.enableRoute) {
          add(UpdatePolylinesMap(localtionState.locationHistory));
        }
      }
      if (!state.isFollowingUser) return;
      if (localtionState.lastKnowLocation == null) return;

      moveCamera(localtionState.lastKnowLocation!);
    });

    on<UpdatePolylinesMap>(newPolylinePoint);

    on<StartRoute>((event, emit) {
      emit(state.copyWith(showMyRoute: !state.showMyRoute));
    });

    on<PaintRoute>(initPaintintg);
  }

  void initMap(MapInitEvent event, Emitter<MapState> emit) {
    mapController = event.controller;

    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    mapController?.animateCamera(cameraUpdate);
  }

  void newPolylinePoint(UpdatePolylinesMap event, Emitter<MapState> emit) {
    if (locationBloc.state.enableRoute) {
      final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations,
      );

      final currentPolylines = Map<String, Polyline>.from(state.polylines);
      currentPolylines['myRoute'] = myRoute;
      emit(state.copyWith(polylines: currentPolylines));
    }
  }

  void initPaintintg(PaintRoute event, Emitter<MapState> emit) async {
    final Set<Polyline> tempPolylinesRoute = {};
    final List<LatLng> tempListRoute = [];

    final data = await getDataLocations();

    for (var element in data) {
      tempListRoute.add(
        LatLng(element["latitude"], element["longitude"]),
      );
    }

    final paintingRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: tempListRoute,
    );

    tempPolylinesRoute.add(paintingRoute);
    emit(state.copyWith(
      listRoute: tempListRoute,
      polylinesRoute: tempPolylinesRoute,
    ));
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
