import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:huanckengquizz/data/game_modes.dart';
import 'package:huanckengquizz/models/game_mode.dart';
import 'package:huanckengquizz/models/question.dart';
import 'package:huanckengquizz/screens/summary.screen.dart';

import '../constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'EngQuizz',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // choose level title
              const Text(
                'Pick your level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              Column(
                children: [
                  _gameModeButton(
                    EASY_GAMEMODE,
                    context,
                  ),
                  const SizedBox(height: 40),
                  _gameModeButton(
                    MEDIUM_GAMEMODE,
                    context,
                  ),
                  const SizedBox(height: 40),
                  _gameModeButton(
                    HARD_GAMEMODE,
                    context,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _gameModeButton(GameMode mode, BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => SummaryScreen(mode: mode),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(maxHeight: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: mode.color.withOpacity(0.25),
              offset: const Offset(3, 10),
              blurRadius: 15,
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
                    mode.color.withOpacity(0.75),
                    mode.color.withOpacity(0.5),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      const Icon(
                        FluentIcons.arrow_right_24_filled,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  // showing best scores of the mode
                  // FutureBuilder<int>(
                  //   future: mode.getBestScores(),
                  //   builder: (context, snapshot) {
                  //     return snapshot.hasData
                  //         ? Text(
                  //             "Best: ${snapshot.data!}",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.w200,
                  //               fontFamily: appFontFamily,
                  //               shadows: [
                  //                 BoxShadow(
                  //                   color: Colors.black.withOpacity(0.5),
                  //                   offset: const Offset(3, 3),
                  //                   blurRadius: 10,
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         : const Text("---");
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
