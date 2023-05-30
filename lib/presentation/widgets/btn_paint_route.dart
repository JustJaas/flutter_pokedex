import 'package:flutter/material.dart';
import 'package:maps_routes/presentation/pages/painting_route.dart';

class BtnPaintRoute extends StatelessWidget {
  const BtnPaintRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      maxRadius: 25,
      child: IconButton(
        icon: const Icon(
          Icons.map_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaintingRoute()),
          );
        },
      ),
    );
  }
}
