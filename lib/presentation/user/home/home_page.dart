import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                actions: [IconButton(onPressed: () {

                }, icon: const Icon(Icons.drag_handle))],
              ),

            ],
          ),
          Positioned(
            top: -150,
            left: -250,
            child: SvgPicture.asset(
              'assets/appbar_drone.svg',
            ),
          ),

        ],
      ),
    );
  }
}
