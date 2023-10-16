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

  List images = [];
  List<String> selectedCards = [];
  List<bool> listBooleans = [];
  int seleccion = 1;
  int indexCartaUno = 0;
  int indexCartaDos = 0;
  String cartaUno = '';
  String cartaDos = '';

  @override
  void initState() {
    super.initState();
    if (widget.numPares == 8) {
      images = listaOchoPares;
      images.shuffle();
      listBooleans = List.filled(widget.numPares * 2, false);
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
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final img = images[index];
                    return FadeIn(
                      delay: Duration(seconds: 1),
                      child: FlipCard(
                        side: listBooleans[index] == false ? CardSide.BACK : CardSide.FRONT,
                          onFlip: () {
                            if (selectedCards.length < 2) {
                              if (seleccion == 1) {
                                setState(() {
                                  cartaUno = img;
                                  selectedCards.add(cartaUno);
                                  listBooleans[index] = true;
                                  indexCartaUno = index;
                                  seleccion++;
                                });
                              } else {
                                setState(() {
                                  cartaDos = img;
                                  selectedCards.add(cartaDos);
                                  listBooleans[index] = true;
                                  indexCartaDos = index;
                                  seleccion++;
                                });
                              }
                            }
                    
                            if (selectedCards.length == 2) {
                              // Si ambas cartas son iguales
                              if (cartaUno == cartaDos) {
                                setState(() {
                                  selectedCards.clear();
                                  cartaUno = '';
                                  cartaDos = '';
                                });
                              } else {
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    selectedCards.clear();
                                    cartaUno = '';
                                    cartaDos = '';
                                    listBooleans[indexCartaUno] = false;
                                    listBooleans[indexCartaDos] = false;
                                  });
                                });
                              }
                              setState(() {
                                seleccion = 1;
                              });
                            }
                          },
                          flipOnTouch: selectedCards.length < 2,
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
