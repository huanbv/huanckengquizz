import 'Question.dart';

class GameMode {
  final String name; // tên chế độ (Easy, Medium, Hard)
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
  });
}

class Game {
  final List<Question> questions;
  final GameMode mode;

  Game(this.questions, this.mode);

  void start() {}
}
