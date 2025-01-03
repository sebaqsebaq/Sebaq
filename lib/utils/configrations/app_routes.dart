import 'package:flutter/material.dart';

import '../../presentation/login_screen.dart';
import '../../presentation/splash_screen.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes() {
  return {
    AppRotes.splashPage: (context) => const SplashScreen(),
    AppRotes.login: (context) => const LoginScreen()
  };
}

class AppRotes {
  static const String splashPage = '/';
  static const String login = '/login';
}
