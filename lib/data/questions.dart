import 'package:flutter/cupertino.dart';
import 'package:huanckengquizz/models/question.dart';

// download here: https://www.flaticon.com/search?word=animals&type=icon

final questions = [
  Question(
    suggestionImage: Image.asset('assets/animals/bee.svg').image,
    answer: 'Bee',
    noises: ['Fly', 'Bug', 'Butterfly'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/rhino.svg').image,
    answer: 'Rhino',
    noises: ['Alligator', 'Elephant', 'Hippo'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/snake.svg').image,
    answer: 'Snake',
    noises: ['Scorpion', 'Spider', 'Annaconda'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/swift.svg').image,
    answer: 'Swift',
    noises: ['Dove', 'Hummingbird', 'Eagle'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/buffalo.svg').image,
    answer: 'Buffalo',
    noises: ['Cow', 'Goat', 'Sheep'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/chicken.svg').image,
    answer: 'Chicken',
    noises: ['Duck', 'Peacock', 'Ostrich'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/mosquito.svg').image,
    answer: 'Mosquito',
    noises: ['Dragonfly', 'Flies', 'Mantis'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/bear.svg').image,
    answer: 'Bear',
    noises: ['Monkey', 'Ape', 'Dog'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/lion.svg').image,
    answer: 'Lion',
    noises: ['Tiger', 'Fox', 'Cheetah'],
  ),
  Question(
    suggestionImage: Image.asset('assets/animals/dolphin.svg').image,
    answer: 'Dolphin',
    noises: ['Penguin', 'Seal', 'Otter'],
  ),
];
