import 'package:flutter/material.dart';
import 'package:test_game/src/feature/home/model/game_level_model.dart';

class GameGrid extends StatelessWidget {
  final GameLevel level;
  final Function(int, int) onTileTap;

  const GameGrid({
    Key? key,
    required this.level,
    required this.onTileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: level.gridSize,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      padding: EdgeInsets.all(4),
      itemCount: level.gridSize * level.gridSize,
      itemBuilder: (context, index) {
        int row = index ~/ level.gridSize;
        int col = index % level.gridSize;
        String imageName = level.grid[row][col];

        return index == 0
            ? Container()
            : GestureDetector(
                onTap: imageName.isNotEmpty ? () => onTileTap(row, col) : null,
                child: imageName.isNotEmpty
                    ? Image.asset('assets/images/game/$imageName')
                    : Image.asset('assets/images/game/green.png'),
              );
      },
    );
  }
}
