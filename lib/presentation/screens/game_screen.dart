import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorama/images_list.dart';

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
  int _seleccion = 1;
  int _indexCartaUno = 0;
  int _indexCartaDos = 0;
  String _cartaUno = '';
  String _cartaDos = '';

  @override
  void initState() {
    super.initState();
    if (widget.numPares == 8) {
      _images = listaOchoPares;
      _images.shuffle();
      _listBooleans = List.filled(widget.numPares * 2, false);
    } else if (widget.numPares == 10) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    final img = _images[index];
                    if(index == 8){

                    }
                    return FadeIn(
                      delay: Duration(milliseconds: 500),
                      child: FlipCard(
                        side: _listBooleans[index] == false ? CardSide.FRONT : CardSide.BACK,
                          onFlip: () {
                            _listBooleans[index] = true;
                            if (_selectedCards.length < 2) {
                              if (_seleccion == 1) {
                                setState(() {
                                  _cartaUno = img;
                                  _selectedCards.add(_cartaUno);
                                  _indexCartaUno = index;
                                  _seleccion++;
                                });
                              } else {
                                setState(() {
                                  _cartaDos = img;
                                  _selectedCards.add(_cartaDos);
                                  
                                  _indexCartaDos = index;
                                  _seleccion++;
                                });
                              }
                            }
                    
                            if (_selectedCards.length == 2) {
                              // Si ambas cartas son iguales
                              if (_cartaUno == _cartaDos) {
                                setState(() {
                                  _selectedCards.clear();
                                  _cartaUno = '';
                                  _cartaDos = '';
                                });
                              } else {
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    _selectedCards.clear();
                                    _cartaUno = '';
                                    _cartaDos = '';
                                    _listBooleans[_indexCartaUno] = false;
                                    _listBooleans[_indexCartaDos] = false;
                                  });
                                });
                              }
                              setState(() {
                                _seleccion = 1;
                              });
                            }
                          },
                          flipOnTouch: _listBooleans[index] == false,
                          front: const Card(child: Icon(Icons.question_mark, size: 40)),
                          back: ClipRRect(child: Image.asset('assets/$img', scale: 2.5))),
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
