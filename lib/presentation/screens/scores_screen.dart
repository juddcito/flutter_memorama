import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorama/db/database_helper.dart';

class ScoresScreen extends StatefulWidget {
  ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  String puntuacionOchoPares = '';
  String puntuacionDiezPares = '';
  String puntuacionDocePares = '';
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    _getPuntuaciones();
    super.initState();
  }

  Future<void> _getPuntuaciones() async {
    await databaseHelper.initializeDatabase();

    final resultadoOchoPares = await databaseHelper.getMinScoreAndTime(8);
    final resultadoOcho = resultadoOchoPares['min_score'] ??
        (puntuacionOchoPares = 'No hay puntuaciones');

    final resultadoDiezPares = await databaseHelper.getMinScoreAndTime(10);
    final resultadoDiez = resultadoDiezPares['min_score'] ??
        (puntuacionDiezPares = 'No hay puntuaciones');

    final resultadoDocePares = await databaseHelper.getMinScoreAndTime(12);
    final resultadoDoce = resultadoDocePares['min_score'] ??
        (puntuacionDocePares = 'No hay puntuaciones');

    setState(() {
      puntuacionOchoPares = resultadoOcho;
      puntuacionDiezPares = resultadoDiez;
      puntuacionDocePares = resultadoDoce;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mejores puntuaciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInRight(
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.emoji_events_outlined, size: 32),
                  title: const Text('8 pares',
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text(puntuacionOchoPares),
                ),
              ),
            ),
            FadeInRight(
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.emoji_events_outlined, size: 32),
                  title: const Text('10 pares',
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text(puntuacionDiezPares),
                ),
              ),
            ),
            FadeInRight(
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.emoji_events_outlined, size: 32),
                  title: const Text('12 pares',
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text(puntuacionDocePares),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
