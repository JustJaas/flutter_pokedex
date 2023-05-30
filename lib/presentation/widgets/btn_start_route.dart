import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_routes/presentation/blocs/location/location_bloc.dart';

class BtnStartRoute extends StatelessWidget {
  const BtnStartRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25,
              child: IconButton(
                onPressed: () {
                  locationBloc.add(StartRoute());
                },
                icon: Icon(
                  state.enableRoute ? Icons.stop : Icons.play_arrow,
                ),
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
