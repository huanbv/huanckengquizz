import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huanckengquizz/data/game_modes.dart';
import 'package:huanckengquizz/models/game_mode.dart';

import '../constants.dart';
import '../game_controller.dart';

// nhóm các modes lại vào mảng để xử lý hiển thị
var GAMEMODES = [
  EASY_GAMEMODE,
  MEDIUM_GAMEMODE,
  HARD_GAMEMODE,
];

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    var MODES = [...GAMEMODES]; // clone - sao chép giá trị các phần tử (tránh xóa vì sẽ gây index out of range)
    // xóa game mode mà người dùng đã chọn (còn lại 2 game mode khác)
    MODES.removeWhere((element) => element.name == controller.mode.name);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // trả về false để chặn người dùng back trở lại route trước
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _gameModeCard(controller.mode, context),
                // const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your best scores',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        fontFamily: appFontFamily,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(3, 5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                    _gameModeCard(MODES[0], context),
                    const SizedBox(height: 30),
                    _gameModeCard(MODES[1], context),
                  ],
                ),
                _restartButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _restartButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(vertical: 10),
        constraints: const BoxConstraints(maxHeight: 70),
        decoration: BoxDecoration(
          color: controller.mode.color.withOpacity(0.75),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: controller.mode.color.withOpacity(0.25),
              offset: const Offset(3, 10),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restart Quizz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                fontFamily: appFontFamily,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(3, 5),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            const Icon(
              FluentIcons.arrow_reset_24_regular,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  _gameModeCard(GameMode mode, BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints(maxHeight: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: mode.color.withOpacity(0.5),
            offset: const Offset(10, 10),
            // blurRadius: 50,
          ),
        ],
      ),
      child: Stack(
        children: [
          Image(
            image: mode.backgroundImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  mode.color.withOpacity(0.75),
                  mode.color.withOpacity(0.5),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (mode.name == controller.mode.name) ...{
                      Text(
                        'Your Quizz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: appFontFamily,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(3, 3),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                      ),
                    },
                    Text(
                      mode.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: appFontFamily,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(3, 3),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // showing best scores of the mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (mode.name == controller.mode.name) ...{
                      // điểm người dùng vừa chơi xong
                      Text(
                        "Scores: ${controller.scores}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          fontFamily: appFontFamily,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(3, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    },

                    // điểm cao nhất
                    FutureBuilder<int>(
                      future: mode.getBestScores(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Text(
                                "Best: ${snapshot.data!}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: appFontFamily,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(3, 3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              )
                            : const Text("---");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
