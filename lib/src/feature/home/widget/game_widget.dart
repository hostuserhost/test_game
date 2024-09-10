import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_game/src/feature/home/model/game_level_model.dart';
import 'package:test_game/src/feature/home/widget/game_grid_widget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  late GameLevel gameLevel;
  late Timer timer;
  int remainingTime = 0;
  int currentLevel = 1;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    gameLevel = GameLevel.create(currentLevel);
    remainingTime = gameLevel.timerSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void onTileTap(int row, int col) {
    setState(() {
      gameLevel.incrementTile(row, col);
    });
  }

  void resetGame() {
    setState(() {
      gameLevel.reset();
      remainingTime = gameLevel.timerSeconds;
      startTimer();
    });
  }

  void changeLevel() {
    setState(() {
      currentLevel = (currentLevel % 3) + 1;
      startNewGame();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: changeLevel,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/images/game/top.png'),
              ),
            ),
          ),
          Expanded(
            child: GameGrid(
              level: gameLevel,
              onTileTap: onTileTap,
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/game/bottom.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment(0, -0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(204, 98, 12, 1),
                        ),
                        color: Color.fromRGBO(204, 98, 12, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'timer   ${formatTime(remainingTime)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: resetGame,
                    child: Image.asset('assets/images/game/restart_button.png',
                        height: 50),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
