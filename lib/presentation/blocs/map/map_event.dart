part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapInitEvent extends MapEvent {
  final GoogleMapController controller;
  const MapInitEvent(this.controller);
}

class UpdatePolylinesMap extends MapEvent {
  final List<LatLng> userLocations;
  const UpdatePolylinesMap(this.userLocations);
}

class StartRoute extends MapEvent {}

class PaintRoute extends MapEvent {
  final Set<Polyline>? polylinesRoute;
  final List<LatLng>? listRoute;

  const PaintRoute({this.polylinesRoute, this.listRoute});
}
