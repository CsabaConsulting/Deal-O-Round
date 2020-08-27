import '../../services/settings_constants.dart';
import '../game_page.dart';
import 'play_card.dart';
import 'shoe.dart';

class Board {
  static const SHOE_SIZE = 4;

  final shoe = Shoe(SHOE_SIZE);
  List<List<PlayCard>> board;
  final BoardLayout layout;
  final indexes = Iterable<int>.generate(GameState.BOARD_SIZE).toList();

  Board({this.layout}) {
    shoe.shuffleAll();
    board = indexes
        .map((i) => getRandomCards(GameState.BOARD_SIZE +
            (layout == BoardLayout.Hexagonal && i % 2 == 0 ? -1 : 0)))
        .toList();
  }

  @override
  String toString() {
    return board
        .map((col) => col.map((c) => c.toString()).toList().join('_'))
        .toList()
        .join('|');
  }

  List<PlayCard> getRandomCards(int size) {
    return List<PlayCard>.generate(size, (i) => shoe.dealCard());
  }

  removeHand() {
    // TODO: animate removal and insertion of cards; needs _listKeys
    /*
    // Step 1: bubble the removed cards to the top
    for (var x in indexes) {
      int displacement = 0;
      for (var y in indexes.reversed) {
        if (board[x][y].selected) {
          displacement += 1;
        } else if (displacement > 0) {
          board[x][y + displacement] = board[x][y];
          board[x][y] =
              PlayCard(suit: Suit.Invalid, value: Value.Invalid);
          board[x][y].selected = true;
        }
      }
    }
    // Step 2: deal the removed cards
    for (var x in indexes) {
      for (var y in indexes) {
        if (board[x][y].selected) {
          board[x][y] = shoe.dealCard();
        }
      }
    }
  */
    for (var x in indexes) {
      final selCount = board[x].fold(0, (f, n) => f + (n.selected ? 1 : 0));
      if (selCount > 0) {
        board[x] = List.generate(selCount, (i) => shoe.dealCard()) +
            board[x].where((c) => !c.selected).toList();
      }
    }
  }
}
