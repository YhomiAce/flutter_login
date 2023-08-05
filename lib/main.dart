// ignore_for_file: prefer_const_constructors

import 'package:flut_auth/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ThemeData().copyWith().colorScheme.copyWith(
              secondary: Colors.redAccent,
            ),
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 8,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 22, color: Colors.redAccent),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.blueAccent,
          ),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
