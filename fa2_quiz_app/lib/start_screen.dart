import 'package:flutter/material.dart';
import 'package:fa2_quiz_app/commons/styled_text.dart';

const double titleSize = 30;
const double subtitleSize = 20;

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        Image.asset(
          'assets/uaap.jpg',
          width: 300,
          height: 200,
        ),

        StyledText(
          'The UAAP Quiz',
          titleSize,
          color: Colors.black,
        ),

        StyledText(
          'Featuring Far Eastern University as the 89th Host',
          subtitleSize,
          color: Colors.black,
        ),

        OutlinedButton.icon(
          onPressed: startQuiz,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.black,
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.play_arrow),
          label: StyledText(
            'Start Quiz',
            15,
            color: const Color.fromARGB(255, 243, 245, 243),
          ),
        ),
      ],
    );
  }
}