import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  late SharedPreferences _localStorage;
  Brightness brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  AppTheme._internal();

  factory AppTheme(SharedPreferences localStorage) {
    _instance._localStorage = localStorage;
    return _instance;
  }
  static AppTheme get instance => _instance;
  ThemeData resolveBrightness() {
    final isDarkMode = _localStorage.getBool('isDarkMode');
    return ThemeData(
      colorSchemeSeed: Colors.green,
      useMaterial3: true,
      brightness: isDarkMode == true
          ? Brightness.dark
          : isDarkMode == false
              ? Brightness.light
              : brightness,
      fontFamily: 'Roboto',
    );
  }

  void toggleBrightness() {
    final isDarkMode = _localStorage.getBool('isDarkMode') ?? false;
    _localStorage.setBool('isDarkMode', !isDarkMode);
    notifyListeners();
  }
}
