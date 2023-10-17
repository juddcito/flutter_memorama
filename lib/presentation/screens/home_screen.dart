

// ignore_for_file: sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorama/db/database_helper.dart';
import 'package:flutter_memorama/presentation/screens/pregame_screen.dart';
import 'package:flutter_memorama/presentation/screens/scores_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
          
                // logo
                FadeInRight(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/grape.png',
                      scale: 2.5,
                    ),
                  ),
                ),
    
                const SizedBox(height: 45,),
    
                FadeInRight(
                  child: Container(
                    width: 250,
                    child: FilledButton.tonalIcon(
                      label: const Text('Jugar'),
                      icon: const Icon(Icons.play_arrow_outlined),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const PregameScreen()));
                      },
                    ),
                  ),
                ),
    
                const SizedBox(height: 15,),
    
                FadeInRight(
                  child: Container(
                    width: 250,
                    child: FilledButton.tonalIcon(
                      label: const Text('Puntuaciones'),
                      icon: const Icon(Icons.emoji_events_outlined),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ScoresScreen()));
                      },
                    ),
                  ),
                ),
                
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}