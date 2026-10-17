import 'package:flutter/material.dart';
import 'package:fa2_quiz_app/commons/styled_text.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 500,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: StyledText(
          text,
          20,
          color: const Color.fromARGB(255, 32, 117, 11),
        ),
      ),
    );
  }
}
