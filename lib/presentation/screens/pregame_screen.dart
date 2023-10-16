

import 'package:flutter/material.dart';

class PregameScreen extends StatelessWidget {
  const PregameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cantidad de pares'),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('8 pares'),
            value: 1,
            groupValue: 1,
            onChanged:(value) {
              
            },
          ),
          RadioListTile(
            title: const Text('10 pares'),
            value: 1,
            groupValue: 1,
            onChanged:(value) {
              
            },
          ),
          RadioListTile(
            title: const Text('12 pares'),
            value: 1,
            groupValue: 1,
            onChanged:(value) {
              
            },
          ),

          FilledButton.tonal(onPressed: (){}, child: Text('Empezar'))
        ],
      ),
    );
  }
}