// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Answer {
  final String title;
  final bool isTrue;

  Answer({
    required this.title,
    this.isTrue = false,
  });
}

class Question {
  final ImageProvider suggestionImage; // đường dẫn ảnh gợi ý
  final List<Answer> answers; // các đáp án

  Question({
    required this.suggestionImage,
    required this.answers,
  })  : assert(answers.length == 4), // ràng buộc số lượng đáp án phải là 4
        assert(answers.where((element) => element.isTrue).length ==
            1); // ràng buộc chỉ được có 1 đáp áp đúng trong số 4 đáp án

  /// getting shuffled answers for this question
  // List<String> getShuffledAnswers() {}
}
