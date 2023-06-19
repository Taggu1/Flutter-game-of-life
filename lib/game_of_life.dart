import 'dart:math';

import 'package:flutter_game_of_life/utils.dart';

class GameOfLife {
  final double cellSize;
  List<List<bool>> _world = [];
  int rowsCount;
  int columnsCount;
  bool _playing = true;
  List<List<bool>> get world => _world;
  bool get playing => _playing;
  GameOfLife({
    required this.rowsCount,
    required this.columnsCount,
    required this.cellSize,
  }) {
    _world = createEmptyCells();
    createRandomCells();
  }

  void switchGameState() {
    _playing = !_playing;
  }

  void changeCellState(int x, int y) {
    _world[x][y] = !_world[x][y];

    compute();
  }

  void reset() {
    _world = createEmptyCells();
  }

  List<List<bool>> createEmptyCells() {
    return List.generate(
      columnsCount,
      (i) => List.filled(
        rowsCount,
        false,
      ),
    );
  }

  void createRandomCells() {
    final nextGen = createEmptyCells();
    for (int i = 0; i < columnsCount; i++) {
      for (int j = 0; j < rowsCount; j++) {
        nextGen[i][j] = Random().nextBool();
      }
    }
    _world = nextGen;
  }

  void compute() {
    if (_playing == false) return;
    List<List<bool>> nextGen = createEmptyCells();
    for (int i = 0; i < columnsCount; i++) {
      for (int j = 0; j < rowsCount; j++) {
        final state = _world[i][j];

        final niegbours = countNieghbours(i, j);

        if (state == false && niegbours == 3) {
          nextGen[i][j] = true;
        } else if (state == true && (niegbours < 2 || niegbours > 3)) {
          nextGen[i][j] = false;
        } else {
          nextGen[i][j] = state;
        }
      }
    }
    _world = nextGen;
  }

  int countNieghbours(int x, int y) {
    int sum = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        final col = (x + i + columnsCount) % columnsCount;
        final row = (y + j + rowsCount) % rowsCount;
        sum += _world[col][row].toInt();
      }
    }

    sum -= _world[x][y].toInt();
    return sum;
  }
}
