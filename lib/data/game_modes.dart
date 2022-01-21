import 'package:flutter/material.dart';
import 'package:huanckengquizz/models/game_mode.dart';

final EASY_GAMEMODE = GameMode(
  name: 'Easy',
  backgroundImage: Image.asset('lib/assets/backgrounds/easy_mode.jpeg').image,
  questionsLimit: 10,
  countdownSeconds: 30,
  bonusScores: 10,
  minusScores: 5,
  color: Colors.blue,
);

final MEDIUM_GAMEMODE = GameMode(
  name: 'Medium',
  backgroundImage: Image.asset('lib/assets/backgrounds/medium_mode.jpg').image,
  questionsLimit: 10,
  countdownSeconds: 20,
  bonusScores: 20,
  minusScores: 10,
  color: Colors.orange,
);

final HARD_GAMEMODE = GameMode(
  name: 'Hard',
  backgroundImage: Image.asset('lib/assets/backgrounds/hard_mode.jpg').image,
  questionsLimit: 10,
  countdownSeconds: 10,
  bonusScores: 30,
  minusScores: 15,
  color: Colors.purple,
);
