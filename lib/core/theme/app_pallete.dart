import 'package:flutter/material.dart';

class AppPallete {
  static const LinearGradient kLinearGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 33, 150, 243),
      Color.fromARGB(255, 109, 169, 1),
    ],
  );
  static const Color transparentColor = Colors.transparent;
  static ColorScheme kColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 33, 150, 243));

  static ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(251, 109, 169, 1));
}
