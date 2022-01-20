import 'dart:async';

import 'package:flutter/material.dart';

import 'data/questions.dart';
import 'models/game.dart';
import 'models/question.dart';

// lớp xử lý logic game
class GameController extends ChangeNotifier {
  late bool playing;
  late GameMode mode;
  late int scores;
  late int counter;
  late List<Question> questions; // danh sách câu hỏi cho game hiện tại
  late int currentQuestionIndex; // Thứ tự hiện tại của câu hỏi
  late Timer timer;
  late void Function() onTimeout; // hàm gọi khi thời gian game kết thúc
  late void Function(GameController)
      onTimerTick; // hàm gọi mỗi giây khi thời gian game trôi qua

  // câu hỏi hiện tại dựa vào index
  Question get currentQuestion => questions[currentQuestionIndex];

  GameController({
    required this.mode,
    required this.onTimerTick,
    required this.onTimeout,
  }) {
    questions = _getShuffledQuestions(mode.questionsLimit);
    counter = mode.countdownSeconds;
    scores = 0;
    currentQuestionIndex = 1;
    playing = false;
  }

  void start() {
    playing = true;

    // bắt đầu chạy timer đếm ngược
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        // khi counter đếm về 0 (hết thời gian)
        // dừng timer
        timer.cancel();
        playing = false;

        onTimeout(); // gọi hàm callback để thực thi ở màn hình
        return;
      }

      onTimerTick(this);
    });

    // thông báo cho giao diện cập nhật lại thông tin
    notifyListeners();
  }

  void pause() {
    playing = false;
    notifyListeners();
  }

  void resume() {
    playing = true;
    notifyListeners();
  }

  /// lấy danh sách câu hỏi cho game hiện tại
  List<Question> _getShuffledQuestions(int quantity) {
    QUESTIONS.shuffle(); // xáo trộn thứ tự câu hỏi trong danh sách
    return QUESTIONS.take(quantity).toList();
  }

  /// lấy danh sách xáo trộn đáp án cho câu hỏi hiện tại
  List<Answer> getShuffledAnswerForQuestion(Question question) {
    question.answers.shuffle(); // xáo trộn thứ tự đáp án trong danh sách
    return question.answers.toList();
  }
}
