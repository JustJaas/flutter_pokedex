import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_mexico/presentation/blocs/gps/gps_bloc.dart';

class GpsEnabledPage extends StatelessWidget {
  const GpsEnabledPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return !state.isGpsEnabled
                ? const Text(
                    "Necesita habilitar el GPS",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Es necesario el acceso al GPS"),
                      MaterialButton(
                        color: Colors.black,
                        shape: const StadiumBorder(),
                        elevation: 0,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          final gpsBloc = BlocProvider.of<GpsBloc>(context);
                          gpsBloc.askGpsAccess();
                        },
                        child: const Text(
                          "Solicitar Acceso",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
