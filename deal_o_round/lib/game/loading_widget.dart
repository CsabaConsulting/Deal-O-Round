import 'package:flutter/material.dart';
import 'background_painter.dart';

class GameOverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 64,
        fontFamily: 'Musicals',
        color: Colors.white
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Text("Game Over", style: textStyle)
        )
      )
    );
  }
}
