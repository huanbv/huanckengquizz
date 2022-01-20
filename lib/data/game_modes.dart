import 'package:flutter/material.dart';
import 'package:huanckengquizz/models/game.dart';

final easyGameMode = GameMode(
  name: 'Easy',
  backgroundImage: Image.asset('lib/assets/backgrounds/easy_mode.jpeg').image,
  questionsLimit: 10,
  countdownSeconds: 30,
  bonusScores: 10,
  minusScores: 5,
  color: Colors.blue,
);

final mediumGameMode = GameMode(
  name: 'Medium',
  backgroundImage: Image.asset('lib/assets/backgrounds/medium_mode.jpg').image,
  questionsLimit: 10,
  countdownSeconds: 20,
  bonusScores: 20,
  minusScores: 10,
  color: Colors.amber,
);

final hardGameMode = GameMode(
  name: 'Hard',
  backgroundImage: Image.asset('lib/assets/backgrounds/hard_mode.jpg').image,
  questionsLimit: 10,
  countdownSeconds: 10,
  bonusScores: 30,
  minusScores: 15,
  color: Colors.red,
);
