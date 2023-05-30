import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_routes/presentation/blocs/map/map_bloc.dart';

class MapPage extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapPage({
    Key? key,
    required this.initialLocation,
    required this.polylines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 14,
    );

    return SizedBox(
      child: Listener(
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          onMapCreated: (controller) => mapBloc.add(MapInitEvent(controller)),
        ),
      ),
    );
  }
}
