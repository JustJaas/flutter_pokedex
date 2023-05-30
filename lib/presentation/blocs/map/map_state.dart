part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Set<Polyline> polylinesRoute;
  final List<LatLng> listRoute;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = false,
    Map<String, Polyline>? polylines,
    this.polylinesRoute = const {},
    this.listRoute = const [],
  }) : polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Set<Polyline>? polylinesRoute,
    List<LatLng>? listRoute,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
        polylinesRoute: polylinesRoute ?? this.polylinesRoute,
        listRoute: listRoute ?? this.listRoute,
      );
  @override
  List<Object> get props => [
        isMapInitialized,
        isFollowingUser,
        polylines,
        showMyRoute,
        polylinesRoute,
        listRoute,
      ];
}
