import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/game.dart';
import 'models/question.dart';

// lớp xử lý logic game
class GameController extends ChangeNotifier {
  late List<Question> allQuestions; // danh sách tất cả câu hỏi
  late GameMode mode;
  late int scores;
  late int counter;
  late List<Question> activeQuestions; // danh sách câu hỏi cho game hiện tại
  late int currentQuestionIndex; // Thứ tự hiện tại của câu hỏi
  late Timer timer;
  late void Function() onTimeout; // hàm gọi khi thời gian game kết thúc
  // late void Function(GameController) onTimerTick; // hàm gọi mỗi giây khi thời gian game trôi qua

  // câu hỏi hiện tại dựa vào index
  Question get currentQuestion => activeQuestions[currentQuestionIndex];

  // liệu rằng game vẫn đang chạy? (chưa bị pause)
  bool get playing => timer.isActive && counter > 0;

  GameController({
    required this.allQuestions,
  });

  void start(GameMode mode, void Function() onTimeout) {
    this.onTimeout = onTimeout;

    activeQuestions = _getShuffledQuestions(mode.questionsLimit);
    counter = mode.countdownSeconds;
    scores = 0;
    currentQuestionIndex = 1;

    startTimer();
    log('new game');

    // thông báo cho giao diện cập nhật lại thông tin
    notifyListeners();
  }

  void startTimer() {
    // bắt đầu chạy timer đếm ngược
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        // khi counter đếm về 0 (hết thời gian)
        // dừng timer
        timer.cancel();

        onTimeout(); // gọi hàm callback để thực thi ở màn hình
        return;
      }

      log('tick...');
      --counter;
      notifyListeners();
    });
  }

  void pause() {
    timer.cancel();
    notifyListeners();
  }

  void resume() {
    startTimer();
  }

  /// lấy danh sách câu hỏi cho game hiện tại
  List<Question> _getShuffledQuestions(int quantity) {
    allQuestions.shuffle(); // xáo trộn thứ tự câu hỏi trong danh sách
    return allQuestions.take(quantity).toList();
  }
}
