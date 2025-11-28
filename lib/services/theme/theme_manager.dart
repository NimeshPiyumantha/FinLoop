import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeManager._(); // Private constructor

  static Future<ThemeManager> create() async {
    final manager = ThemeManager._();
    await manager._loadThemeMode(); // Ensure theme is loaded
    return manager;
  }

  void toggleTheme(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      saveThemeMode(mode);
      notifyListeners();
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString().split('.').last);
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'light';
    _themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.toString().split('.').last == themeString,
      orElse: () => ThemeMode.light,
    );
  }
}
