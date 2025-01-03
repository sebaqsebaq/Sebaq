import 'package:flutter/material.dart';
import 'package:untitled1/utils/configrations/app_routes.dart';
import 'package:untitled1/utils/configrations/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: getAppRoutes(),
      theme: AppTheme.shared.getThemeData(),
    );
  }
}
