import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Borrowing Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFE7DA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F372B),
          primary: const Color(0xFF0F372B),
          secondary: const Color(0xFFE8392B),
          surface: const Color(0xFFEFE7DA),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F372B),
          foregroundColor: Color(0xFFEFE7DA),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}