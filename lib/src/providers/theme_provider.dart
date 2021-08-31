import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isActive) {
    themeMode = isActive ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static final darkTheme = ThemeData(
    primaryColor: Colors.red.shade900,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.green),
    appBarTheme: AppBarTheme(brightness: Brightness.dark),
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.red.shade900,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.green),
    appBarTheme: AppBarTheme(brightness: Brightness.light),
  );
}
