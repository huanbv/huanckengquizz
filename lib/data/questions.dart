import 'package:flutter/cupertino.dart';
import 'package:huanckengquizz/models/question.dart';

// download here: https://www.flaticon.com/search?word=animals&type=icon

final QUESTIONS = [
  Question(
    suggestionImage: Image.asset('lib/assets/animals/bee.png').image,
    answers: [
      Answer(title: 'Bee', isTrue: true),
      Answer(title: 'Fly'),
      Answer(title: 'Bug'),
      Answer(title: 'Butterfly'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/rhino.png').image,
    answers: [
      Answer(title: 'Rhino', isTrue: true),
      Answer(title: 'Alligator'),
      Answer(title: 'Elephant'),
      Answer(title: 'Hippo'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/snake.png').image,
    answers: [
      Answer(title: 'Snake', isTrue: true),
      Answer(title: 'Scorpion'),
      Answer(title: 'Spider'),
      Answer(title: 'Annaconda'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/swift.png').image,
    answers: [
      Answer(title: 'Swift', isTrue: true),
      Answer(title: 'Dove'),
      Answer(title: 'HummingbirdSwift'),
      Answer(title: 'Eagle'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/buffalo.png').image,
    answers: [
      Answer(title: 'Buffalo', isTrue: true),
      Answer(title: 'Cow'),
      Answer(title: 'GoatBuffalo'),
      Answer(title: 'Sheep'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/chicken.png').image,
    answers: [
      Answer(title: 'Chicken', isTrue: true),
      Answer(title: 'Duck'),
      Answer(title: 'PeacockChicken'),
      Answer(title: 'Ostrich'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/mosquito.png').image,
    answers: [
      Answer(title: 'Mosquito', isTrue: true),
      Answer(title: 'Dragonfly'),
      Answer(title: 'Flies'),
      Answer(title: 'Mantis'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/bear.png').image,
    answers: [
      Answer(title: 'Bear', isTrue: true),
      Answer(title: 'Monkey'),
      Answer(title: 'Ape'),
      Answer(title: 'Dog'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/lion.png').image,
    answers: [
      Answer(title: 'Lion', isTrue: true),
      Answer(title: 'Tiger'),
      Answer(title: 'Fox'),
      Answer(title: 'Cheetah'),
    ],
  ),
  Question(
    suggestionImage: Image.asset('lib/assets/animals/dolphin.png').image,
    answers: [
      Answer(title: 'Dolphin', isTrue: true),
      Answer(title: 'Penguin'),
      Answer(title: 'SealDolphin'),
      Answer(title: 'Otter'),
    ],
  ),
];
