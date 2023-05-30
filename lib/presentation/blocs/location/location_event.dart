part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class NewLocationEvent extends LocationEvent {
  final LatLng newLocation;
  final bool showRoute;
  const NewLocationEvent(this.newLocation, this.showRoute);
}

class StartRoute extends LocationEvent {}
