import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/GameEvent.dart';
import 'package:tictactoe/GameState.dart';

import 'Square.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  GameBloc(GameState initialState) : super(initialState);

  final _allWins = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    final currentState = state;

    if (event is ResetEvent) {

      if (currentState is GameEnded) {
        yield GameInitializedState(isNextPlayerX: true);
      }
    }

    if (event is UserClickEvent) {
      if (currentState is GameInitializedState) {
        final index = event.index;
        final gameData = [
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,
          SquareState.None,];

        gameData[index] =
        currentState.isNextPlayerX ? SquareState.PlayerX : SquareState.PlayerO;

        yield GameOnGoingState(
            gameData: gameData, isNextPlayerX: !currentState.isNextPlayerX);
      } else if (currentState is GameOnGoingState) {
        final index = event.index;
        switch (currentState.gameData[index]) {
          case SquareState.None:
            final gameData = currentState.gameData;
            gameData[index] = currentState.isNextPlayerX
                ? SquareState.PlayerX
                : SquareState.PlayerO;

            yield calculateGameState(gameData, !currentState.isNextPlayerX);
            break;
          case SquareState.PlayerO:
            break;
          case SquareState.PlayerX:
            break;
        }
      }
    }
  }

  GameState calculateGameState(List<SquareState> gameData, bool isNextPlayerX) {
    for (var i = 0; i < _allWins.length; i++) {
      var win = _allWins[i];

      if (gameData[win[0]] != SquareState.None &&
          gameData[win[0]] == gameData[win[1]] &&
          gameData[win[1]] == gameData[win[2]]) {
        return gameData[win[0]] == SquareState.PlayerO
            ? GameEndWithWinner(isWinnerX: false, gameData: gameData)
            : GameEndWithWinner(isWinnerX: true, gameData: gameData);
      }
    }

    for (var i = 0; i < gameData.length; i++) {
      if (gameData[i] == SquareState.None) {
        return GameOnGoingState(gameData: gameData, isNextPlayerX: isNextPlayerX);
      }
    }

    return GameEndWithoutWinner(gameData: gameData);
  }

}