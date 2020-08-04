import 'package:flutter/material.dart';
import '../game/logic/play_card.dart';
import '../game/logic/suit.dart';
import '../game/logic/value.dart';
import 'chip_painter.dart';
import 'chip_selection_painter.dart';

class ChipWidget extends StatelessWidget {
  final PlayCard card;
  String _suit;
  String _value;
  bool _selected = false;
  bool _neighbor = false;

  ChipWidget({
    this.card
  }) {
    this._suit = suitCharacter(card.suit);
    this._value = valueCharacter(card.value);
  }

  setSelected() {
    _selected = true;
  }

  setNeighbor() {
    _neighbor = true;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = (_suit == 'C' || _suit == 'S') ?
      Colors.black : Colors.red;
    final suitStyle = TextStyle(
      fontSize: 50,
      fontFamily: 'Cards',
      color: textColor
    );
    final valueStyle = TextStyle(
      fontSize: 50,
      fontFamily: 'Stint-Ultra-Condensed',
      fontWeight: FontWeight.w700,
      color: textColor
    );

    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: ChipPainter(),
        foregroundPainter: ChipSelectionPainter(
            selected: _selected, neighbor: _neighbor),
        child: Center(
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.visible,
            text: TextSpan(
              text: _value,
              style: valueStyle,
              children: <TextSpan>[
                TextSpan(text: _suit, style: suitStyle)
              ]
            )
          )
        )
      )
    );
  }
}
