import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {

  static final AppTheme shared = AppTheme();

  ThemeData getThemeData() {
    return ThemeData(scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor);
  }
}