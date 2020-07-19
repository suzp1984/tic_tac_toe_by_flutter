import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/GameBloc.dart';
import 'package:tictactoe/GameBoard.dart';
import 'package:tictactoe/GameEvent.dart';
import 'package:tictactoe/GameState.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {

  GameBloc _gameBloc;

  _playerClicked(int index) {
    log('player clicked $index');
    _gameBloc.add(UserClickEvent(index: index));
  }

  _reset() {
    _gameBloc.add(ResetEvent());
  }

  @override
  void initState() {
    super.initState();

    _gameBloc = BlocProvider.of<GameBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
            var gameTitle = "UnKnow State";

            if (state is GameEndWithWinner) {
              gameTitle = state.isWinnerX ? "Winner is X" :
              "Winner is O";
            } else if (state is GameEndWithoutWinner) {
              gameTitle = "No Winner in this round";
            } else if (state is GameInitializedState) {
              gameTitle =
              state.isNextPlayerX ? "Next Player X" : "Next Player O";
            } else if (state is GameOnGoingState) {
              gameTitle =
              state.isNextPlayerX ? "Next Player X" : "Next Player O";
            }

            return Text(
              gameTitle,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            );
          }
        ),
        Container(
            margin: EdgeInsets.only(top: 20.0),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return GameBoard(
                    gameData: state.gameData, playerClicked: _playerClicked);
              },
            )),
        RaisedButton(
          onPressed: () {
            _reset();
          },
          child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Text(
              "Reset",
              style: TextStyle(
                  color: (state is GameInitializedState ||
                          state is GameOnGoingState)
                      ? Colors.grey
                      : Colors.green),
            );
          },
        ))
      ],
    );
  }
}

