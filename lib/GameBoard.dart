import 'package:flutter/material.dart';
import 'package:tictactoe/Game.dart';

import 'Square.dart';

class GameBoard extends StatelessWidget {
  GameBoard({Key key, this.playerClicked, this.gameData}) : super(key: key);

  final Function(int index) playerClicked;
  final List<SquareState> gameData;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Row(children: <Widget>[
          GestureDetector(
            onTap: () {
              playerClicked(0);
            },
            child: Square(state: gameData[0]),
          ),
          GestureDetector(
            onTap: () {
              playerClicked(1);
            },
            child: Transform.translate(
                offset: const Offset(-2.0, 0.0),
                child: Square(state: gameData[1])),
          ),
          GestureDetector(
            onTap: () {
              playerClicked(2);
            },
            child: Transform.translate(
                offset: const Offset(-4.0, 0.0),
                child: Square(state: gameData[2])),
          )
        ]),
        Transform.translate(
            offset: const Offset(0.0, -2.0),
            child: Row(children: <Widget>[
              GestureDetector(
                onTap: () {
                  playerClicked(3);
                },
                child: Square(state: gameData[3]),
              ),
              GestureDetector(
                onTap: () {
                  playerClicked(4);
                },
                child: Transform.translate(
                    offset: const Offset(-2.0, 0.0),
                    child: Square(state: gameData[4])),
              ),
              GestureDetector(
                onTap: () {
                  playerClicked(5);
                },
                child: Transform.translate(
                    offset: const Offset(-4.0, 0.0),
                    child: Square(state: gameData[5])),
              )
            ])),
        Transform.translate(
            offset: const Offset(0.0, -4.0),
            child: Row(children: <Widget>[
              GestureDetector(
                onTap: () {
                  playerClicked(6);
                },
                child: Square(state: gameData[6]),
              ),
              GestureDetector(
                onTap: () {
                  playerClicked(7);
                },
                child: Transform.translate(
                    offset: const Offset(-2.0, 0.0),
                    child: Square(state: gameData[7])),
              ),
              GestureDetector(
                onTap: () {
                  playerClicked(8);
                },
                child: Transform.translate(
                    offset: const Offset(-4.0, 0.0),
                    child: Square(state: gameData[8])),
              )
            ]))
      ],
    ));
  }
}
