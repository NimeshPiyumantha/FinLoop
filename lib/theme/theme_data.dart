import 'package:flutter/material.dart';
import 'font_theme.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class LogicContextThemeManager {

  late ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.surface,
    textTheme: fontTheme.apply(
      bodyColor: lightColorScheme.onSurface,
      displayColor: lightColorScheme.onSurface,
    ),

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightColorScheme.onSurface),
      titleTextStyle: fontTheme.headlineSmall?.copyWith(
        color: lightColorScheme.onSurface,
      ),
    ),


    cardTheme: CardThemeData(
      color: lightColorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),


    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColorScheme.surface,
      hintStyle: fontTheme.bodyMedium?.copyWith(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // Dark Theme
  late ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.surface,
    textTheme: fontTheme.apply(
      bodyColor: darkColorScheme.onSurface,
      displayColor: darkColorScheme.onSurface,
    ),

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkColorScheme.onSurface),
      titleTextStyle: fontTheme.headlineSmall?.copyWith(
        color: darkColorScheme.onSurface,
      ),
    ),

    cardTheme: CardThemeData(
      color: darkColorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}