import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDFF3E5),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double imageWidth = constraints.maxWidth * 0.5;
              return Image.asset(
                'assets/splash.jpeg',
                width: imageWidth,
              );
            },
          ),
        ),
      ),
    );
  }
}