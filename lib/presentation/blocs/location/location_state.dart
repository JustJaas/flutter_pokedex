part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> locationHistory;
  final bool enableRoute;
  final List<LatLng>? tempLocation;

  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation,
    this.enableRoute = false,
    locationHistory,
    this.tempLocation,
  }) : locationHistory = locationHistory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? locationHistory,
    bool? enableRoute,
    List<LatLng>? tempLocation,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
        locationHistory: locationHistory ?? this.locationHistory,
        enableRoute: enableRoute ?? this.enableRoute,
        tempLocation: tempLocation ?? this.tempLocation,
      );

  @override
  List<Object?> get props => [
        followingUser,
        lastKnowLocation,
        locationHistory,
        enableRoute,
        tempLocation,
      ];
}
