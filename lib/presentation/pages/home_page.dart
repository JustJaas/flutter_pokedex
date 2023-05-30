import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_mexico/presentation/blocs/gps/gps_bloc.dart';
import 'package:maps_mexico/presentation/blocs/location/location_bloc.dart';
import 'package:maps_mexico/presentation/blocs/map/map_bloc.dart';
import 'package:maps_mexico/presentation/pages/gps_enabled_page.dart';
import 'package:maps_mexico/presentation/pages/map_page.dart';
import 'package:maps_mexico/presentation/widgets/btn_paint_route.dart';
import 'package:maps_mexico/presentation/widgets/btn_start_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);

    final showRoute = mapBloc.state.showMyRoute;

    locationBloc.getCurrentPosition(showRoute);
    locationBloc.startFollow(showRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          if (state.isAllGranted) {
            return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, stateLocation) {
                if (stateLocation.lastKnowLocation == null) {
                  return const Center(
                    child: Text("Espere..."),
                  );
                }
                return BlocBuilder<MapBloc, MapState>(
                  builder: (context, stateMap) {
                    Map<String, Polyline> polylines =
                        Map.from(stateMap.polylines);
                    if (!stateLocation.enableRoute) {
                      polylines.removeWhere((key, value) {
                        return key == 'myRoute';
                      });
                    }
                    return MapPage(
                      initialLocation: stateLocation.lastKnowLocation!,
                      polylines: stateMap.polylines.values.toSet(),
                    );
                  },
                );
              },
            );
          } else {
            return const GpsEnabledPage();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnPaintRoute(),
          SizedBox(height: 5),
          BtnStartRoute(),
        ],
      ),
    );
  }
}
