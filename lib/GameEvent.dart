import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserClickEvent extends GameEvent {
  final int index;

  UserClickEvent({this.index});

  @override
  List<Object> get props => [this.index];
}

class ResetEvent extends GameEvent {
}