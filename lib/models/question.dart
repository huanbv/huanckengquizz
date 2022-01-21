// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Answer {
  final String imagePath;
  final String title;
  bool isTrue;

  Answer({
    required this.title,
    required this.imagePath,
    this.isTrue = false,
  });
}

class Question {
  final List<Answer> answers; // các đáp án

  // đường dẫn ảnh gợi ý dựa vào đáp án đúng
  ImageProvider get suggestionImage => Image.asset(
        answers.firstWhere((element) => element.isTrue).imagePath,
      ).image;

  Question({required this.answers})
      : assert(
          answers.length == 4,
          "Question doesn't have engough answers (4 requried)",
        ), // ràng buộc số lượng đáp án phải là 4
        assert(
          answers.where((element) => element.isTrue).length == 1,
          "Question have more than right 1 answer.",
        ); // ràng buộc chỉ được có 1 đáp áp đúng trong số 4 đáp án

  // khởi tạo Question từ list đường dẫn ảnh
  static Question fromListImagePaths(List<String> imagePaths) {
    imagePaths.shuffle(); // shuffling to get randomly right answer
    final trueImagePath = imagePaths.first;

    return Question(
      answers: imagePaths
          .map((path) => Answer(
                title: getAnimalNameFromPath(path),
                imagePath: path,
                isTrue: path == trueImagePath,
              ))
          .toList(),
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

  // thay đổi đáp án đúng ngẫu nhiên
  void shuffleTheRightAnswer() {
    // bỏ đáp án đúng mặc định
    answers.firstWhere((element) => element.isTrue).isTrue = false;

    // trộn thứ tự
    answers.shuffle();

    // gán lại đáp án đúng
    answers.first.isTrue = true;
  }
}
