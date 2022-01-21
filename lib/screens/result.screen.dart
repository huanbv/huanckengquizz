import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../game_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // trả về false để chặn người dùng back trở lại route trước
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _restartButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _restartButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).pop();
      },
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(vertical: 10),
        constraints: const BoxConstraints(maxHeight: 70),
        decoration: BoxDecoration(
          color: controller.mode.color.withOpacity(0.75),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: controller.mode.color.withOpacity(0.25),
              offset: const Offset(3, 10),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restart Quizz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                fontFamily: appFontFamily,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(3, 5),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            const Icon(
              FluentIcons.arrow_reset_24_regular,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
