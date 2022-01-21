import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/game_mode.dart';
import 'models/question.dart';

// lớp xử lý logic game
class GameController extends ChangeNotifier {
  late List<Question> allQuestions; // danh sách tất cả câu hỏi
  late GameMode mode; // game mode người chơi đã chọn ở màn hình 1
  late int scores; // tổng điểm khi bắt đầu game
  late int counter; // biến đếm thời gian còn lại của game
  late List<Question> activeQuestions; // danh sách câu hỏi cho game hiện tại
  late int currentQuestionIndex; // Thứ tự hiện tại của câu hỏi
  late Timer timer; // timer dùng cho việc đếm

  late void Function() onTimeout; // hàm gọi khi thời gian game kết thúc
  late void Function(bool isTrue, int receivedScores)
      onAnswerPicked; // hàm gọi khi người dùng chọn đáp án để chạy animation

  // câu hỏi hiện tại dựa vào index
  Question get currentQuestion => activeQuestions[currentQuestionIndex - 1];

  // liệu rằng game vẫn đang chạy? (chưa bị pause)
  bool get playing => timer.isActive && counter > 0;

  GameController({
    required this.allQuestions,
  });

  void start({
    required GameMode mode,
    required void Function() onTimeout,
    required void Function(bool isTrue, int receivedScores) onAnswerPicked,
  }) {
    this.onAnswerPicked = onAnswerPicked;
    this.onTimeout = onTimeout;
    this.mode = mode;

    scores = 0; // tổng điểm
    currentQuestionIndex = 1; // câu hỏi hiện tại
    counter = mode.countdownSeconds; // counter bắt đầu bằng tổng số giây
    // lấy ngẫu nhiên các câu hỏi từ bộ ngân hàng câu hỏi
    activeQuestions = _getShuffledQuestions(mode.questionsLimit);

    startTimer();
    log('new game');
  }

  void startTimer() {
    // bắt đầu chạy timer đếm ngược
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        // khi counter đếm về 0 (hết thời gian)
        // dừng timer
        timer.cancel();

        // chờ 2s trước khi chuyển qua màn hình kết quả
        Timer(const Duration(seconds: 2), () {
          onTimeout(); // gọi hàm callback để thực thi ở màn hình
        });

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

  /// hàm chuyển qua câu hỏi tiếp theo
  void next() {
    // kiểm tra xem đã là câu cuối cùng hay chưa? nếu rồi thì chuyển qua màn hình kết quả
    if (currentQuestionIndex == activeQuestions.length) {
      timer.cancel();

      // chờ 2s trước khi chuyển qua màn hình kết quả
      Timer(const Duration(seconds: 2), () {
        onTimeout(); // gọi hàm callback để thực thi ở màn hình
      });

      return;
    }

    currentQuestionIndex++;
    // trộn đáp án đúng của câu kế tiếp
    currentQuestion.shuffleTheRightAnswer();
    notifyListeners();
  }

  /// lấy danh sách câu hỏi cho game hiện tại
  List<Question> _getShuffledQuestions(int quantity) {
    allQuestions.shuffle(); // xáo trộn thứ tự câu hỏi trong danh sách
    return allQuestions.take(quantity).toList();
  }

  /// khi nút đáp án của một câu hỏi được nhấn
  void onAnswerPressed(Answer answer) {
    if (answer.isTrue) {
      // chọn vào câu trả lời đúng
      scores += mode.bonusScores;
      log('right answer: +${mode.bonusScores}');
    } else {
      // chọn vào câu trả lời sai
      scores -= mode.minusScores;
      log('wrong answer: -${mode.minusScores}');
    }

    // gọi hàm callback thực thi logic animation ở Screen
    onAnswerPicked(answer.isTrue, answer.isTrue ? mode.bonusScores : mode.minusScores);
    next();
  }
}
