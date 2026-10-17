import 'package:flutter/material.dart';
import 'package:fa2_quiz_app/start_screen.dart';
import 'package:fa2_quiz_app/question/question_screen.dart';
import 'package:fa2_quiz_app/result_screen.dart';
import 'package:fa2_quiz_app/data/questions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeScreen = 'start-screen';
  var questionIndex = 0;
  var score = 0;

  void startQuiz() {
    setState(() {
      activeScreen = 'question-screen';
      questionIndex = 0;
      score = 0;
    });
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      score++;
    }

    setState(() {
      if (questionIndex == questions.length - 1) {
        activeScreen = 'result-screen';
      } else {
        questionIndex++;
      }
    });
  }

  void backToStart() {
    setState(() {
      activeScreen = 'start-screen';
      questionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = StartScreen(startQuiz);

    if (activeScreen == 'question-screen') {
      currentScreen = QuestionScreen(
        questionIndex,
        answerQuestion,
      );
    }

    if (activeScreen == 'result-screen') {
      currentScreen = ResultScreen(
        score,
        backToStart,
      );
    }

    return MaterialApp(
      title: 'The UAAP Quiz',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 251, 252),
        body: Center(
          child: currentScreen,
        ),
      ),
      debugShowCheckedModeBanner: false, 
    );
  }
}