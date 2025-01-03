import 'package:flutter/material.dart';
import 'dart:async';

import 'package:untitled1/utils/configrations/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRotes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF3E5),
      body: Center(
        child: Image.asset(
          'assets/splash.jpeg',
          width: 200,
        ),
      ),
    );
  }
}
