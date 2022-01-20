import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:huanckengquizz/models/game.dart';
import 'package:huanckengquizz/screens/playing.screen.dart';

import '../constants.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final GameMode mode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _gameModeCard(context),
                  const SizedBox(height: 20),
                  _gameMeta(),
                ],
              ),
              const SizedBox(height: 20),
              _startButton(context),
            ],
          ),
        ),
      ),
    );
  }

  _gameMeta() {
    _gameMetaRow(String title, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _gameMetaRow('Level', mode.name),
        _gameMetaRow('Total questions', "${mode.questionsLimit}"),
        _gameMetaRow('Total time', "${mode.countdownSeconds} secs"),
        _gameMetaRow('Bonus', "+${mode.bonusScores}"),
        _gameMetaRow('Minus', "-${mode.minusScores}"),
      ],
    );
  }

  _gameModeCard(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints(maxHeight: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(3, 3),
            blurRadius: 24,
          ),
        ],
      ),
      child: Stack(
        children: [
          Image(
            image: mode.backgroundImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  mode.color.withOpacity(0.35),
                  mode.color.withOpacity(0.5),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        FluentIcons.arrow_left_24_filled,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      mode.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: appFontFamily,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(3, 3),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // _gameModeCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _startButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => PlayingScreen(mode: mode),
          ),
        );
      },
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(vertical: 10),
        constraints: const BoxConstraints(maxHeight: 70),
        decoration: BoxDecoration(
          color: mode.color.withOpacity(0.75),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              offset: const Offset(3, 10),
              blurRadius: 24,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Quizz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                fontFamily: appFontFamily,
              ),
            ),
            const SizedBox(width: 30),
            const Icon(
              FluentIcons.arrow_right_24_filled,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
