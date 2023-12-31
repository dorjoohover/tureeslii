import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/theme/text_theme.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
        background: Colors.white,
        primary: prime,
        brightness: Brightness.light,
        error: red,
        onPrimary: prime,
        secondary: prime,
        onSecondary: prime,
        onError: red,
        onBackground: Colors.white,
        surface: gray,
        onSurface: gray),
    textTheme: const TextTheme(
        titleMedium: headline,
        titleLarge: headlineLarge,
        titleSmall: headlineSmall,
        displaySmall: displaySmall,
        bodyMedium: body,
        bodySmall: bodySmall,
        labelMedium: smallText,
        labelLarge: largeText),
  );
  static ThemeData dark = ThemeData();
}
