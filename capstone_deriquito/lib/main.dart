import 'package:flutter/material.dart';
import 'package:capstone_deriquito/colors.dart';
import 'package:capstone_deriquito/screens/home_screen.dart';

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
        scaffoldBackgroundColor: bone,
        colorScheme: ColorScheme.fromSeed(
          seedColor: bottleGreen,
          primary: bottleGreen,
          surface: bone,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bone,
          foregroundColor: bottleGreen,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}