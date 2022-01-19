import 'package:huanckengquizz/models/game.dart';

final easyGameMode = GameMode(
  name: 'Easy',
  questionsLimit: 10,
  countdownSeconds: 30,
  bonusScores: 10,
  minusScores: 5,
);

final mediumGameMode = GameMode(
  name: 'Medium',
  questionsLimit: 10,
  countdownSeconds: 20,
  bonusScores: 20,
  minusScores: 10,
);

final hardGameMode = GameMode(
  name: 'Hard',
  questionsLimit: 10,
  countdownSeconds: 10,
  bonusScores: 30,
  minusScores: 15,
);
