import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Question.dart';

class GameMode {
  final String name; // tên chế độ (Easy, Medium, Hard)
  final ImageProvider backgroundImage;
  final Color color;
  final int questionsLimit; // số lượng câu hỏi
  final int countdownSeconds; // thời gian đếm ngược cho 1 game
  final int bonusScores; // điểm cộng khi trả lời đúng
  final int minusScores; // điểm trừ khi trả lời sai

  GameMode({
    required this.name,
    required this.questionsLimit,
    required this.countdownSeconds,
    required this.bonusScores,
    required this.minusScores,
    required this.backgroundImage,
    required this.color,
  });

  // khởi tạo instance của SharedPreferences
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  // lấy điểm cao nhất của mode hiện tại
  Future<int> getBestScores() async {
    return (await _prefs).getInt(name) ?? 0;
  }

  /// Lưu điểm cao nhất
  Future saveScores(int scores) async {
    // so sánh, nếu điểm đưa vào :scores lớn hơn điểm cao nhất của mode hiện tại
    if (await getBestScores() < scores) {
      (await _prefs).setInt(name, scores);
    }
  }
}
