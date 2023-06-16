import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_game_of_life/game_painter.dart';
import 'package:touchable/touchable.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: game.grid.xCount / game.grid.yCount,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CanvasTouchDetector(
                  builder: (context) {
                    return CustomPaint(
                      painter: GamePainter(
                        context,
                        game,
                      ),
                    );
                  },
                  gesturesToOverride: [
                    GestureType.onTapDown,
                  ],
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_ticker.isActive) {
              _ticker.stop();
            } else {
              _ticker.start();
            }
            setState(() {});
          },
          child: Text(
            _ticker.isActive ? "Stop" : "Start",
          ),
        ),
      ],
    );
  }
}
