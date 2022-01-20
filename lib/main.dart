import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:huanckengquizz/game_controller.dart';

import 'package:huanckengquizz/models/question.dart';
import 'package:huanckengquizz/screens/welcome.screen.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: loadQuestions(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {}

        return ChangeNotifierProvider(
          // cung cấp 1 new instance của GameController cho toàn bộ app
          create: (_) => GameController(allQuestions: snapshot.data!),
          child: MaterialApp(
            title: 'EngQuizz',
            theme: ThemeData(
              fontFamily: appFontFamily,
              textTheme: appTextTheme,
            ),
            home: const WelcomeScreen(),
          ),
        );
      },
    );
  }
}

Future<List<Question>> loadQuestions(BuildContext context) async {
  log('...loading question images...');

  // đọc toàn bộ đường dẫn assets trong pubspec.yaml
  final manifestText = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> manifestJson = json.decode(manifestText);
  // print(manifestJson);

  // lọc ra các đường dẫn tới các ảnh animals
  final questionImageFolders =
      manifestJson.keys.where((String key) => key.startsWith('lib/assets/questions/')).toList();
  // print(questionImageFolders);

  // nhóm các đường dẫn ảnh animal theo thứ tự thư mục
  var groupedPathsByFolder =
      groupBy(questionImageFolders, (e) => (e as String).split('lib/assets/questions/')[1].split('/')[0]);
  print(groupedPathsByFolder);

  return groupedPathsByFolder.entries.map((e) => Question.fromListImagePaths(e.value)).toList();
}
