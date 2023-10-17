import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorama/db/database_helper.dart';
import 'package:flutter_memorama/images_list.dart';
import 'package:flutter_memorama/presentation/screens/home_screen.dart';
import 'package:intl/intl.dart';

class GameScreen extends StatefulWidget {
  final int numPares;

  GameScreen({super.key, required this.numPares});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {


  List _images = [];
  List<String> _selectedCards = [];
  List<bool> _listBooleans = [];
  List<GlobalKey<FlipCardState>> cardKeys = [];
  int _seleccion = 1;
  int _indexCartaUno = 0;
  int _indexCartaDos = 0;
  int _score = 0;
  int _counter = 0;
  String _cartaUno = '';
  String _cartaDos = '';
  late Timer _timer;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  String _formatDuration(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    return DateFormat.Hms().format(DateTime(0, 0, 0, duration.inHours,
        duration.inMinutes % 60, duration.inSeconds % 60));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    databaseHelper.initializeDatabase();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {   
    setState(() {
        _counter++;
      });
    });

    if (widget.numPares == 8) {
      _images = listaOchoPares;
    } else if (widget.numPares == 10) {
      _images = listaDiezPares;
    } else {
      _images = listaDocePares;
    }

    _images.shuffle();
    _listBooleans = List.filled(widget.numPares * 2, false);

    for (int i = 0; i < widget.numPares * 2; i++) {
      cardKeys.add(GlobalKey<FlipCardState>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(Icons.sports_score_outlined),
            Text('${_score.toString()}/${widget.numPares}'),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Salir'),
                        content: const Text('¿Desea salir al menú principal?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              },
                              child: const Text('Sí'))
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.home_filled)),
            const Spacer(),
            const Icon(Icons.timer),
            const SizedBox(width: 5),
            Text(_formatDuration(_counter))
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    final img = _images[index];
                    return FadeIn(
                      child: FlipCard(
                          key: cardKeys[index],
                          onFlipDone: (isFront) {
                            if (isFront) {
                              if (_selectedCards.length < 2) {
                                if (_seleccion == 1) {
                                  _cartaUno = img;
                                  _selectedCards.add(_cartaUno);
                                  _indexCartaUno = index;
                                  setState(() {
                                    _listBooleans[index] = true;
                                  });
                                } else {
                                  _cartaDos = img;
                                  _selectedCards.add(_cartaDos);
                                  _indexCartaDos = index;
                                  setState(() {
                                    _listBooleans[index] = true;
                                  });
                                }
                                _seleccion++;
                              }

                              if (_selectedCards.length == 2) {
                                // Si ambas cartas son iguales
                                if (_cartaUno == _cartaDos) {
                                  setState(() {
                                    _score++;
                                    if (_score == widget.numPares) {
                                      
                                      databaseHelper.insertScore(widget.numPares, _formatDuration(_counter));
                                      _timer.cancel();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            icon: const Icon(Icons.star_border, size: 32),
                                            title: const Text('Has ganado!'),
                                            actions: [
                                              FilledButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen()));
                                                },
                                                child: const Text('Regresar')
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  });
                                } else {
                                  setState(() {
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      _listBooleans[_indexCartaUno] = false;
                                      _listBooleans[_indexCartaDos] = false;
                                      cardKeys[_indexCartaUno]
                                          .currentState
                                          ?.toggleCard();
                                      cardKeys[_indexCartaDos]
                                          .currentState
                                          ?.toggleCard();
                                    });
                                  });
                                }
                                _selectedCards.clear();
                                _cartaUno = '';
                                _cartaDos = '';
                                _seleccion = 1;
                              }
                            }
                          },
                          //side: _listBooleans[index] == false
                          //? CardSide.FRONT
                          //: CardSide.BACK,
                          flipOnTouch:
                              _listBooleans[index] == false ? true : false,
                          front: const Card(
                              child: Icon(Icons.question_mark, size: 40)),
                          back: Image.asset('assets/$img', scale: 1)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
