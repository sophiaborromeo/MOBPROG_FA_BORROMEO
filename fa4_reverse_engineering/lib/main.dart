import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fireflies',
      theme: buildTheme(kLightColorScheme, isDark: false),
      darkTheme: buildTheme(kDarkColorScheme, isDark: true),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
