import 'package:flutter/material.dart';
import 'package:fa2_quiz_app/commons/styled_button.dart';
import 'package:fa2_quiz_app/commons/styled_text.dart';
import 'package:fa2_quiz_app/data/questions.dart';

const double questionSize = 25;

class QuestionScreen extends StatelessWidget {
  const QuestionScreen(this.questionIndex, this.answerQuestion, {super.key,});

  final int questionIndex;
  final void Function(bool) answerQuestion;

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[questionIndex];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 15,
      children: [
        Image.asset(
          'assets/uaap2.jpg',
          width: 500,
          height: 100,
        ),

        StyledText(
          currentQuestion.text,
          questionSize,
          color: const Color.fromARGB(255, 23, 56, 9),
        ),

        ...currentQuestion.answers.map(
          (answer) => StyledButton(
            text: answer,
            onPressed: () {
              answerQuestion(
                answer == currentQuestion.correctAnswer,
              );
            },
          ),
        ),
      ],
    );
  }
}