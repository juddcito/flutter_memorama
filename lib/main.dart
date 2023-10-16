import 'package:flutter/material.dart';
import 'package:flutter_memorama/config/app_theme.dart';
import 'presentation/screens/home_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()
    );
  }
}
