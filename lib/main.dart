import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/nud_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameWidget(game: NudGame()));
}
