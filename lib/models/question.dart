// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Question {
  final ImageProvider suggestionImage; // đường dẫn ảnh gợi ý
  final String answer; // đáp án đúng
  final List<String> noises; // 3 đáp án gây nhiễu

  Question({
    required this.suggestionImage,
    required this.answer,
    required this.noises,
  });

  /// getting shuffled answers for this question
  List<String> getShuffledAnswers() {}
}
