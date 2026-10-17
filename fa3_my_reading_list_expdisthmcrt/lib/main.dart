import 'package:fa3_my_reading_list_expdisthmcrt/screens/reading_list_screen.dart';
import 'package:flutter/material.dart';

const Color kSeedColor = Color.fromARGB(255, 97, 5, 69);
const double kDefaultPadding = 20;
const double kCardRadius = 15;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kSeedColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 6,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        elevation: 2,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Reading List',
      theme: _buildTheme(),
      home: const ReadingListScreen(),
    );
  }
}
