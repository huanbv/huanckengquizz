import 'package:flutter/material.dart';
import 'package:huanckengquizz/models/game_mode.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.mode,
    required this.scores,
  }) : super(key: key);

  final GameMode mode;
  final int scores;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${scores}"));
  }
}
