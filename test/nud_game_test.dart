import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nud_game/game/nud_game.dart';

void main() {
  group('NudGame', () {
    testWithGame<NudGame>(
      'boots without throwing',
      NudGame.new,
      (game) async {
        expect(game.isLoaded, isTrue);
      },
    );
  });
}
