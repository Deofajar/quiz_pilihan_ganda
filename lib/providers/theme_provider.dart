import 'package:flutter/material.dart';

/// Menyimpan mode tema (terang/gelap) untuk seluruh aplikasi.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  /// Ganti terang <-> gelap, lalu beri tahu widget yang mendengarkan.
  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
