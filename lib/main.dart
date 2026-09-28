import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  //runApp start entrie flutter freamwork
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Global Configuration flag variable
  bool _isDarkMode = false;

  void _toggleTheme(bool newValue) {
    setState(() {
      _isDarkMode = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Manual',

      //1. defining explicit light theme parameters
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      //2. defining explicit dark theme parameters
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      //3. Point to our mode selector variable state toggler
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // we pass the configuration parameters down into the home menu container screen
      home: HomeScreen(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme),
    );
  }
}
