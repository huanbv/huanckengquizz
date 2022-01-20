import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huanckengquizz/models/game.dart';
import 'package:huanckengquizz/screens/result.screen.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final GameMode mode;

  @override
  State<StatefulWidget> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late int scores;
  late int counter;
  late int currentQuestionIndex; // Thứ tự hiện tại của câu hỏi
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // khởi tạo các thông số của game mới
    scores = 0;
    counter = widget.mode.countdownSeconds;
    currentQuestionIndex = 1;

    // khởi tạo Timer và bắt đầu đếm ngược
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        // khi counter đếm về 0 (hết thời gian)
        // dừng timer
        timer.cancel();

        // chuyển qua màn hình kết quả
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ResultScreen(),
          ),
        );

        return;
      }

      // giảm thời gian còn lại
      setState(() {
        --counter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("${counter}"),
      ),
    );
  }
}
