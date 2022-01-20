import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huanckengquizz/data/questions.dart';
import 'package:huanckengquizz/game_controller.dart';
import 'package:huanckengquizz/models/game.dart';
import 'package:huanckengquizz/models/question.dart';
import 'package:huanckengquizz/screens/result.screen.dart';
import 'package:provider/provider.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final GameMode mode;

  @override
  State<StatefulWidget> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late GameController controller;

  @override
  void initState() {
    super.initState();

    // // khởi tạo game controller
    controller = GameController(
      mode: widget.mode,
      onTimerTick: (controller) {
        print('tick...');
        setState(() {
          controller = controller;
        });
      },
      onTimeout: () {
        // chuyển qua màn hình kết quả
        // truyền thông tin game
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ResultScreen(
              mode: widget.mode,
              scores: controller.scores,
            ),
          ),
        );
      },
    );

    controller.start();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   controller = context.watch<GameController>();
  // }

  void onTimerTick() {}
  void onTimeout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // thông tin game hiện tại; nút điều hướng
              _gameMeta(),
              const SizedBox(height: 50),

              // ảnh gợi ý
              Image(
                image: controller.currentQuestion.suggestionImage,
                width: 200,
                height: 200,
              ),

              // các đáp án
              const SizedBox(height: 20),
              _answerButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _gameMeta() {
    _gameMetaItem(IconData iconData, String title, Color color) {
      return Row(
        children: [
          Icon(iconData, size: 30, color: color),
          Text(
            title,
            style: TextStyle(fontSize: 24, color: color),
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // back button
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Icon(FluentIcons.arrow_left_24_regular),
              ),
              onPressed: () {},
            ),

            // centered title
            Text(
              "Question ${controller.currentQuestionIndex}/${controller.questions.length}",
              style: TextStyle(fontSize: 30),
            ),

            // pause/resume button
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: controller.playing
                    ? Icon(FluentIcons.pause_24_regular)
                    : Icon(FluentIcons.play_24_regular),
              ),
              onPressed: () {},
            ),
          ],
        ),

        // game meta stats
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // countdown timer
            _gameMetaItem(
              FluentIcons.clock_24_regular,
              "${controller.counter}s",
              Colors.grey,
            ),

            // gained scores
            _gameMetaItem(
              FluentIcons.reward_24_regular,
              "${controller.scores}",
              Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  _answerButtons() {
    _answerButton(Answer answer) {
      return Flexible(
        flex: 1,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(5, 5),
                  // blurRadius: 20,
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              answer.title,
              style: TextStyle(
                fontFamily: GoogleFonts.francoisOne().fontFamily,
                fontSize: 24,
              ),
            ),
          ),
          onPressed: () {},
        ),
      );
    }

    var _shuffledAnswers =
        controller.getShuffledAnswerForQuestion(controller.currentQuestion);
    const gap = 25.0;

    return Column(
      children: [
        Row(
          children: [
            _answerButton(_shuffledAnswers[0]),
            const SizedBox(width: gap),
            _answerButton(_shuffledAnswers[1]),
          ],
        ),
        const SizedBox(height: gap),
        Row(
          children: [
            _answerButton(_shuffledAnswers[2]),
            const SizedBox(width: gap),
            _answerButton(_shuffledAnswers[3]),
          ],
        ),
      ],
    );
  }
}
