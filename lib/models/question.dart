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

  static Question fromListImagePaths(List<String> imagePaths) {
    imagePaths.shuffle(); // shuffling to get different right answer
    final trueImagePath = imagePaths.first;

    return Question(
      suggestionImage: Image.asset(trueImagePath).image,
      answers:
          imagePaths.map((path) => Answer(title: getAnimalNameFromPath(path), isTrue: path == trueImagePath)).toList(),
    );
  }

  static getAnimalNameFromPath(String path) {
    return path.split('lib/assets/questions/')[1].split('.')[0].split('/')[1].toUpperCase();
  }

  /// lấy danh sách xáo trộn đáp án cho câu hỏi hiện tại
  List<Answer> getShuffledAnswers() {
    answers.shuffle(); // xáo trộn thứ tự đáp án trong danh sách
    return answers.toList();
  }
}
