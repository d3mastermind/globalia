import 'package:flutter/material.dart';
import 'package:globalia/app_theme.dart';
import 'package:globalia/screens/country_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Globalia',
      theme: isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme(),
      home: CountryListScreen(
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
