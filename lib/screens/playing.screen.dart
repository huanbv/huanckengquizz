import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huanckengquizz/game_controller.dart';
import 'package:huanckengquizz/models/game_mode.dart';
import 'package:huanckengquizz/models/question.dart';
import 'package:huanckengquizz/screens/result.screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies...');

    // nhận instance của controller từ hàm main/MyApp
    controller = Provider.of<GameController>(context, listen: false);
    controller.start(widget.mode, () {
      log('timeout...');

      // push to the result screen
      // pushReplacement to prevent user back to the playing screen (but the summary screen)
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => ResultScreen(mode: controller.mode, scores: controller.scores),
        ),
      );
    });
  }

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
              Selector<GameController, Question>(
                builder: (context, currentQuestion, child) {
                  return Image(
                    image: currentQuestion.suggestionImage,
                    width: 200,
                    height: 200,
                  );
                },
                selector: (p0, p1) => p1.currentQuestion,
              ),

              // các đáp án
              const SizedBox(height: 20),
              _answerButtons(),

              const SizedBox(height: 20),
              _navigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _iconButton(IconData icon, void Function() onPressed) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: controller.mode.color),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(5, 5),
              // blurRadius: 15,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: controller.mode.color),
      ),
      onPressed: onPressed,
    );
  }

  _navigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // back button
        _iconButton(CupertinoIcons.clear, () {
          controller.dispose();
          Navigator.of(context).pop();
        }),

        _iconButton(CupertinoIcons.pause, () {}),

        // next button
        _iconButton(FluentIcons.next_24_regular, () {
          controller.next();
        }),
      ],
    );
  }

  _countdownProgressbar(int counter) {
    return Selector<GameController, int>(
      builder: (context, value, child) {
        return SizedBox(
          height: 50,
          width: 50,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  // padding: const EdgeInsets.all(10)
                  width: double.infinity,
                  height: double.infinity,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    value: controller.counter / controller.mode.countdownSeconds,
                    valueColor: AlwaysStoppedAnimation<Color>(controller.mode.color),
                    strokeWidth: 2,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${counter}s",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
      selector: (p0, p1) => p1.counter,
    );
  }

  _gameMeta() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // title - current question index
            Selector<GameController, int>(
              builder: (context, currentQuestionIndex, child) {
                return Text(
                  "Question ${controller.currentQuestionIndex}/${controller.activeQuestions.length}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              selector: (p0, p1) => p1.currentQuestionIndex,
            ),

            Text(
              "${controller.mode.name} mode",
              style: TextStyle(
                color: controller.mode.color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // game meta stats
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // countdown timer
            Selector<GameController, int>(
              builder: (context, counter, child) {
                return _countdownProgressbar(counter);
              },
              selector: (p0, p1) => p1.counter,
            ),

            // gained scores
            Selector<GameController, int>(
              builder: (context, scores, child) {
                return Row(
                  children: [
                    Icon(FluentIcons.heart_24_filled, size: 30, color: controller.mode.color),
                    const SizedBox(width: 5),
                    Text(
                      "$scores",
                      style: TextStyle(fontSize: 24, color: controller.mode.color),
                    ),
                  ],
                );
              },
              selector: (p0, p1) => p1.scores,
            ),
          ],
        ),
      ],
    );
  }

  // nút trả lời (đáp án)
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
              color: answer.isTrue ? Colors.green.shade300 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(5, 5),
                  // blurRadius: 20,
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              answer.title.toLowerCase(),
              style: TextStyle(
                fontFamily: appFontFamily,
                fontSize: 20,
                color: controller.mode.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {},
        ),
      );
    }

    return Selector<GameController, Question>(
      builder: (context, currentQuestion, child) {
        var _shuffledAnswers = controller.currentQuestion.getShuffledAnswers();
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
      },
      selector: (p0, p1) => p1.currentQuestion,
    );
  }
}
