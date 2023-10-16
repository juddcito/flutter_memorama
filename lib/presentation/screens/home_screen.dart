

// ignore_for_file: sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorama/presentation/screens/game_screen.dart';
import 'package:flutter_memorama/presentation/screens/pregame_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
        
              // logo
              ClipRRect(
                child: Image.asset(
                  'assets/cherry.png',
                  scale: 2.5,
                ),
              ),

              const SizedBox(height: 45,),

              Container(
                width: 250,
                child: ElevatedButton.icon(
                  label: const Text('Jugar'),
                  icon: const Icon(Icons.play_arrow),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => PregameScreen()));
                  },
                ),
              ),

              const SizedBox(height: 15,),

              Container(
                width: 250,
                child: ElevatedButton.icon(
                  label: const Text('Puntuaciones'),
                  icon: const Icon(Icons.emoji_events_outlined),
                  onPressed: (){},
                ),
              ),
              
        
            ],
          ),
        ),
      ),
    );
  }
}