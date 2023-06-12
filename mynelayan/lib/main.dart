import 'package:flutter/material.dart';
import 'package:mynelayan/screens/color_schemes.g.dart';
import 'package:mynelayan/splashscreen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        useMaterial3: true, colorScheme: lightColorScheme
      ),
      home: const SplashScreen(),
    );
  }
}