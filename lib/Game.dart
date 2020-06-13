import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tictactoe/GameBoard.dart';

import 'Square.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}

class GameState extends State<Game> {
  bool isPlayerX = true;
  String gameTitle = "Next Player X";
  GameStatus gameStatus = GameStatus.Idle;

  final gameData = [
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
    SquareState.None,
  ];

  final allWins = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  calculateGameStatus() {
    for (var i = 0; i < allWins.length; i++) {
      var win = allWins[i];

      if (gameData[win[0]] != SquareState.None &&
          gameData[win[0]] == gameData[win[1]] &&
          gameData[win[1]] == gameData[win[2]]) {
        return gameData[win[0]] == SquareState.PlayerO
            ? GameStatus.IsWinnerO
            : GameStatus.IsWinnerX;
      }
    }

    for (var i = 0; i < gameData.length; i++) {
      if (gameData[i] == SquareState.None) {
        return GameStatus.Idle;
      }
    }

    gameStatus = GameStatus.NoWinner;
    return;
  }

  playerClicked(int index) {
    log('player clicked $index');
    if (index < 0 || index >= gameData.length) {
      return;
    }

    if (gameStatus != GameStatus.Idle) {
      return;
    }

    setState(() {
      if (gameData[index] != SquareState.None) {
        return;
      }

      gameData[index] = isPlayerX ? SquareState.PlayerX : SquareState.PlayerO;
      isPlayerX = !isPlayerX;
      gameStatus = calculateGameStatus();

      switch (gameStatus) {
        case GameStatus.IsWinnerO:
          gameTitle = "Winner is Player O";
          break;
        case GameStatus.IsWinnerX:
          gameTitle = "Winner is Player X";
          break;
        default:
          gameTitle = isPlayerX ? "Next Player X" : "Next Player O";
          break;
      }
    });
  }

  reset() {
    setState(() {
      for (var i = 0; i < gameData.length; i++) {
        gameData[i] = SquareState.None;
      }

      gameTitle = isPlayerX ? "Next Player X" : "Next Player O";
      gameStatus = GameStatus.Idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$gameTitle",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: EdgeInsets.only(top: 20.0),
            child: GameBoard(gameData: gameData, playerClicked: playerClicked)),
        RaisedButton(
          onPressed: () {
            if (gameStatus != GameStatus.Idle) {
              reset();
            }
          },
          child: Text(
            "Reset",
            style: TextStyle(
                color:
                    gameStatus != GameStatus.Idle ? Colors.green : Colors.grey),
          ),
        )
      ],
    );
  }
}

enum GameStatus { Idle, IsWinnerX, IsWinnerO, NoWinner }
