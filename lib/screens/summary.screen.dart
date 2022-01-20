import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huanckengquizz/models/game.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(mode.name),
              CupertinoButton(
                onPressed: () {},
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Start Quizz',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // fontFamily: GoogleFonts.francoisOne().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
