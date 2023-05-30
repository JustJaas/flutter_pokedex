import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_routes/presentation/blocs/map/map_bloc.dart';

class PaintingRoute extends StatefulWidget {
  const PaintingRoute({Key? key}) : super(key: key);

  @override
  State<PaintingRoute> createState() => _PaintingRouteState();
}

class _PaintingRouteState extends State<PaintingRoute> {
  final Set<Polyline> polylinesRoute = {};
  final List<LatLng> listRoute = [];
  late MapBloc mapBloc;

  @override
  void initState() {
    mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(const PaintRoute());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return state.listRoute.isEmpty
              ? const Text("Espere...")
              : ShowMapRoute(
                  listRoute: state.listRoute,
                  polylinesRoute: state.polylinesRoute,
                );
        },
      )),
    );
  }
}

class ShowMapRoute extends StatelessWidget {
  final List<LatLng>? listRoute;
  final Set<Polyline>? polylinesRoute;
  const ShowMapRoute({
    Key? key,
    this.listRoute,
    this.polylinesRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition = CameraPosition(
      target: listRoute![0],
      zoom: 15,
    );
    return SizedBox(
      child: Listener(
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylinesRoute!,
        ),
      ),
    );
  }
}
