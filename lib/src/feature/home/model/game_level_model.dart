class GameLevel {
  final int gridSize;
  final int timerSeconds;
  final List<List<String>> grid;

  GameLevel({
    required this.gridSize,
    required this.timerSeconds,
    required this.grid,
  });

  factory GameLevel.create(int level) {
    int gridSize;
    int timerSeconds;

    switch (level) {
      case 1:
        gridSize = 4;
        timerSeconds = 60;
        break;
      case 2:
        gridSize = 5;
        timerSeconds = 45;
        break;
      case 3:
        gridSize = 6;
        timerSeconds = 30;
        break;
      default:
        throw ArgumentError('Invalid level');
    }

    List<List<String>> grid = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => 'one.png'),
    );

    // Устанавливаем некликабельные плитки (пустая строка будет означать некликабельную плитку)
    for (int i = 0; i < gridSize; i++) {
      grid[0][i] = '';
      grid[i][0] = '';
    }

    return GameLevel(
      gridSize: gridSize,
      timerSeconds: timerSeconds,
      grid: grid,
    );
  }

  void incrementTile(int row, int col) {
    if (grid[row][col].isNotEmpty) {
      final images = [
        'one.png',
        'two.png',
        'three.png',
        'four.png',
        'five.png'
      ];
      int currentIndex = images.indexOf(grid[row][col]);
      grid[row][col] = images[(currentIndex + 1) % images.length];
    }
  }

  void reset() {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j].isNotEmpty) {
          grid[i][j] = 'one.png';
        }
      }
    }
  }
}
