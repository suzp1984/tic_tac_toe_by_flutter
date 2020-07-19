import 'package:equatable/equatable.dart';
import 'package:tictactoe/Square.dart';

abstract class GameState extends Equatable {
  List<SquareState> get gameData;

  @override
  List<Object> get props => [];
}

class GameInitializedState extends GameState {
  final bool isNextPlayerX;

  GameInitializedState({this.isNextPlayerX});

  @override
  List<Object> get props => [this.isNextPlayerX];

  @override
  List<SquareState> get gameData => [
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
}

class GameOnGoingState extends GameState {
  final bool isNextPlayerX;

  @override
  final List<SquareState> gameData;

  GameOnGoingState({this.gameData, this.isNextPlayerX});

  @override
  List<Object> get props => [] + this.gameData + [this.isNextPlayerX];

}

abstract class GameEnded extends GameState {
}

class GameEndWithWinner extends GameEnded {
  final bool isWinnerX;

  @override
  final List<SquareState> gameData;

  GameEndWithWinner({this.isWinnerX, this.gameData});

  @override
  List<Object> get props => [] + this.gameData + [this.isWinnerX];
}

class GameEndWithoutWinner extends GameEnded {
  @override
  final List<SquareState> gameData;

  GameEndWithoutWinner({this.gameData});

  @override
  List<Object> get props => this.gameData;
}