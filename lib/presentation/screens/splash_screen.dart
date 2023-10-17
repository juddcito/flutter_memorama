

import 'package:flutter/material.dart';
import 'package:flutter_memorama/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder:(context) => const HomeScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/grape.png', scale: 2.5),
            const SizedBox(height: 50),
            const CircularProgressIndicator(),
            const SizedBox(height: 20,),
            const Text('Cargando cartas...')
          ],
        ),
      ),
    );
  }
}