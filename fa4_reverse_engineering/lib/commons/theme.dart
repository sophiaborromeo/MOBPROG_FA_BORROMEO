import 'package:flutter/material.dart';

const Color defaultColor = Color(0xFFFFD8D0);
const Color darkDefaultColor = Color.fromARGB(255, 88, 40, 26);
const Color wordCounterColor = Color.fromARGB(255, 97, 95, 95);
const Color foregroundColorLight = Colors.white;
const Color foregroundColorDark = Colors.black;
const Color errorColor = Color(0xFFB71C1C);
const double boxSpacing = 10;
const double largeBoxSpacing = 20;
const double textBoxSpacing = 35;
const double textLargeBoxSpacing = 55;
const double buttonSpacing = 15;
const double logoLoginWidth = 500;
const double logoLoginHeight = 400;
const double logoWidth = 400;
const double logoHeight = 300;
const double logoMultiplier = 0.72;
const double horizontalPadding = 24;
const double verticalPadding = 40;
const double iconSize = 20;
const int textMaxLength = 50;
const double headerFontSize = 44;
const double textFontSize = 12;
const double sizedBoxHeight = 32;
const double sizedBoxWidth = 155;
const double textStyleHeight = 1.3;

final kLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: defaultColor,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: darkDefaultColor,
);

ThemeData buildTheme(ColorScheme colorScheme, {required bool isDark}) {
  final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isDark ? darkDefaultColor : defaultColor,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? darkDefaultColor : defaultColor,
      foregroundColor: isDark ? Colors.white : Colors.black,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? defaultColor : darkDefaultColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      counterStyle: TextStyle(
        color: wordCounterColor,
      ),
      errorStyle: TextStyle(
        color: errorColor,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorColor,
          width: 2,
        ),
      ),
    ),
    textTheme: baseTheme.textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondaryContainer,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondaryContainer,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSecondaryContainer,
        fontSize: 15,
      ),
    ),
  );
}
