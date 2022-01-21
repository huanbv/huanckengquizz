import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:huanckengquizz/game_controller.dart';
import 'package:huanckengquizz/models/game_mode.dart';
import 'package:huanckengquizz/models/question.dart';
import 'package:huanckengquizz/screens/result.screen.dart';

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

class _PlayingScreenState extends State<PlayingScreen> with SingleTickerProviderStateMixin {
  late GameController controller;

  // các đối tượng thực hiện animation
  late bool animatingRightScore = false;
  double scoreBottomPosition = -200;

  late AnimationController rightAnswerAnimationController;
  late Animation<double> rightAnswerBottomPositionAnimation;
  late Animation<double> rightAnswerOpacityAnimation;
  late Animation<double> rightAnswerSizeAnimation;
  late Tween<double> bottomPositionTween;
  late Tween<double> opacityTween;
  late Tween<double> sizeTween;

  @override
  void initState() {
    super.initState();

    // khởi tạo animation controller để điểu khiển việc hiển thị điểm khi người dùng chọn đáp án
    rightAnswerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // khởi tạo các đối tượng animation nhằm xác định giá trị khi animation chạy
    bottomPositionTween = Tween<double>(begin: -50, end: -10);
    opacityTween = Tween<double>(begin: 1, end: 0);
    sizeTween = Tween<double>(begin: 0, end: 1);

    rightAnswerBottomPositionAnimation = bottomPositionTween.animate(rightAnswerAnimationController);
    rightAnswerOpacityAnimation = opacityTween.animate(rightAnswerAnimationController);
    rightAnswerSizeAnimation = sizeTween.animate(rightAnswerAnimationController);
  }

  @override
  void dispose() {
    /// giải phóng các tài nguyên không dùng tới
    rightAnswerAnimationController.dispose();

    // must be call at last order
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies...');

    // nhận instance của controller từ hàm main/MyApp
    controller = Provider.of<GameController>(context, listen: false);

    // gọi hàm khởi động game
    controller.start(
      mode: widget.mode,
      onTimeout: () {
        log('timeout...');

        // lưu điểm cao nhất
        controller.mode.saveScores(controller.scores);

        // push to the result screen
        // pushReplacement to prevent user back to the playing screen (but can still back to the summary screen)
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => ResultScreen(controller: controller),
          ),
        );
      },
      onAnswerPicked: (bool isTrue, int receivedScores) {
        // đặt cờ thay đổi màu chữ
        animatingRightScore = isTrue;

        if (!isTrue) {
          sizeTween.begin = 1;
          sizeTween.end = 0;
          // điểm trừ thì rơi từ trên xuống
          bottomPositionTween.begin = -10;
          bottomPositionTween.end = scoreBottomPosition;
        } else {
          // điểm cộng thì đẩy từ dưới lên
          bottomPositionTween.begin = scoreBottomPosition;
          bottomPositionTween.end = -10;
        }

        rightAnswerAnimationController.forward().then((value) {
          // size = 0 để reverse animation về vị trí cũ không hiển thị
          sizeTween.begin = 0;
          sizeTween.end = 0;

          // cheating - but works well..
          rightAnswerAnimationController.reverse().then((value) {
            sizeTween.begin = 0;
            sizeTween.end = 1;
          });
        });
      },
    );
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

              // các nút điều hướng
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
          if (controller.playing) {
            controller.timer.cancel(); // hủy timer để ngăn chặn chồng chéo timer
            Navigator.of(context).pop();
          }
        }),

        // nút tạm dừng game
        Selector<GameController, bool>(
          builder: (context, isTimerActive, child) {
            return _iconButton(
              isTimerActive ? CupertinoIcons.pause : CupertinoIcons.play,
              isTimerActive ? controller.pause : controller.resume,
            );
          },
          selector: (p0, p1) => p1.timer.isActive,
        ),

        // next button
        _iconButton(FluentIcons.next_24_regular, () {
          if (controller.playing) {
            controller.next();
          }
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
        Stack(
          clipBehavior: Clip.none,
          children: [
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

            // điểm thưởng và điểm trừ --- dành cho animation
            AnimatedBuilder(
              animation: rightAnswerAnimationController,
              builder: (context, child) {
                return Positioned(
                  right: 0,
                  bottom: rightAnswerBottomPositionAnimation.value,
                  child: Opacity(
                    opacity: rightAnswerOpacityAnimation.value,
                    child: Transform.scale(
                      scale: rightAnswerSizeAnimation.value,
                      child: Text(
                        animatingRightScore ? "+${controller.mode.bonusScores}" : "-${controller.mode.minusScores}",
                        style: TextStyle(
                          color: animatingRightScore ? Colors.green : Colors.red,
                          fontSize: 72,
                        ),
                      ),
                    ),
                  ),
                );
              },
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
              color: Colors.grey.shade50,
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
          onPressed: () => controller.playing ? controller.onAnswerPressed(answer) : null,
        ),
      );
    }

    return Selector<GameController, Question>(
      builder: (context, currentQuestion, child) {
        // xáo trộn ví trị các đáp án trong câu hỏi hiện tại
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
