

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

                FadeInRightBig(
                  child: const Text(
                    'MEMORAMA',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                const SizedBox(height: 45,),
          
                // logo
                FadeInRight(
                  delay: const Duration(milliseconds: 1500),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/grape.png',
                      scale: 2.5,
                    ),
                  ),
                ),
    
                const SizedBox(height: 45,),
    
                FadeInRight(
                  delay: const Duration(milliseconds: 1500),
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
                  delay: const Duration(milliseconds: 1500),
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

                const Spacer(),

                FadeIn(
                  delay: const Duration(seconds: 1),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 45),
                    child: Chip(
                      avatar: Icon(Icons.copyright),
                      label: Text('Juan De Dios Sapién')
                    ),
                  ),
                )
                
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}