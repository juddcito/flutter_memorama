

import 'package:flutter/material.dart';
import 'package:flutter_memorama/presentation/screens/game_screen.dart';

class PregameScreen extends StatefulWidget {
  const PregameScreen({super.key});

  @override
  State<PregameScreen> createState() => _PregameScreenState();
}

class _PregameScreenState extends State<PregameScreen> {

  int selectedValue = 8;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Niveles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: RadioListTile(
                title: const Text('8 pares'),
                value: 8,
                groupValue: selectedValue,
                onChanged:(value) {
                  setState(() {
                    selectedValue = value as int;
                  });
                },
              ),
            ),
            Card(
              child: RadioListTile(
                title: const Text('10 pares'),
                value: 10,
                groupValue: selectedValue,
                onChanged:(value) {
                  setState(() {
                    selectedValue = value as int;
                  });
                },
              ),
            ),
            Card(
              child: RadioListTile(
                title: const Text('12 pares'),
                value: 12,
                groupValue: selectedValue,
                onChanged:(value) {
                  setState(() {
                    selectedValue = value as int;
                  });
                },
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              width: double.infinity,
              child: FilledButton.icon(onPressed: (){
               Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => GameScreen(numPares: selectedValue)));
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('¡JUGAR!')
              ),
            )
          ],
        ),
      ),
    );
  }
}