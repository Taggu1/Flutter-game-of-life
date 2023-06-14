import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_game_of_life/game_painter.dart';

import 'game_of_life.dart';

class GameOfLifeWidget extends StatefulWidget {
  final Game game;
  const GameOfLifeWidget({super.key, required this.game});

  @override
  State<GameOfLifeWidget> createState() => _GameOfLifeWidgetState();
}

class _GameOfLifeWidgetState extends State<GameOfLifeWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  var _tickCount = 0;

  Game get game => widget.game;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      _tickCount++;
      if (_tickCount % 5 == 0) {
        setState(() => game.tick());
      }
    });
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: game.grid.xCount / game.grid.yCount,
      child: Container(
        color: Colors.red,
        height: double.infinity,
        width: double.infinity,
        child: CustomPaint(
          painter: GamePainter(game),
        ),
      ),
    );
  }
}
