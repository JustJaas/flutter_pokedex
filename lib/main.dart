import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_mexico/presentation/blocs/gps/gps_bloc.dart';
import 'package:maps_mexico/presentation/blocs/location/location_bloc.dart';
import 'package:maps_mexico/presentation/blocs/map/map_bloc.dart';
import 'package:maps_mexico/presentation/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
        create: (context) =>
            MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps Demo',
      home: HomePage(),
    );
  }
}
