import 'package:flutter/material.dart';
import 'package:fa2_quiz_app/commons/styled_text.dart';

const double resultTitleSize = 30;
const double resultTextSize = 20;

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.score, this.backToStart, {super.key});

  final int score;
  final void Function() backToStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15,
      children: [
        Image.asset(
          'assets/uaap.jpg',
          width: 300,
          height: 200,
        ),

        StyledText(
          'Quiz Complete!',
          resultTitleSize,
          color: const Color.fromARGB(255, 6, 94, 10),
        ),

        StyledText(
          'Score: $score out of 5 correct',
          resultTextSize,
          color: const Color.fromARGB(255, 156, 27, 5),
        ),

        OutlinedButton.icon(
          onPressed: backToStart,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.black,
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.refresh),
          label: StyledText(
            'Restart',
            15,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}