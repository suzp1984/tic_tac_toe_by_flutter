
import 'package:flutter/material.dart';

class Square extends StatelessWidget
{
  Square({Key key, this.state}) : super(key: key);

  final SquareState state;

  getText() {
    switch (state){
      case SquareState.None:
        return " ";
      case SquareState.PlayerO:
        return "O";
      case SquareState.PlayerX:
        return "X";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2.0)),
        child: Center(
          child: Text(getText(), style: TextStyle(fontSize: 40.0)),
        ));
  }


}

enum SquareState { PlayerX, PlayerO, None }