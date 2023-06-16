class CellState {
  final bool alive;

  CellState(this.alive);

  bool reactToNeighbours(int neighbours) {
    if (neighbours == 3) {
      return true;
    } else if (neighbours != 2) {
      return false;
    }

    return alive;
  }
}

class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  operator +(covariant Point other) => Point(x + other.x, y + other.y);

  @override
  int get hashCode => x ^ y;

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  @override
  String toString() => '($x, $y)';
}

class Grid {
  final int xCount;
  final int yCount;
  final List<Point> alivePoints;
  Map<Point, bool> field = {};

  Grid(
      {required this.xCount,
      required this.yCount,
      this.alivePoints = const []}) {
    for (var point in alivePoints) {
      field[point] = true;
    }
  }

  static List<Point> neighbourPoints = const [
    Point(-1, -1),
    Point(0, -1),
    Point(1, -1),
    Point(-1, 0),
    Point(1, 0),
    Point(-1, 1),
    Point(0, 1),
    Point(1, 1),
  ];

  int countLiveNeighbours(Point point) =>
      neighbourPoints.where((offset) => field[point + offset] == true).length;

  void iterate({required Function(Point) onUpdate}) {
    for (var x = 0; x < xCount; x++) {
      for (var y = 0; y < yCount; y++) {
        onUpdate(
          Point(x, y),
        );
      }
    }
  }
}

class Game {
  final Grid grid;

  const Game(this.grid);

  void tick() {
    final newField = <Point, bool>{};

    grid.iterate(onUpdate: (point) {
      final cellState = CellState(grid.field[point] ?? false);
      final liveNeighbours = grid.countLiveNeighbours(point);

      newField[point] = cellState.reactToNeighbours(liveNeighbours);
    });

    grid.field = newField;
  }
}
