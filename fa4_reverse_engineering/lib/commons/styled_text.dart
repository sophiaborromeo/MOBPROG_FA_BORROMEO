import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.fontSize, {super.key, required this.color});

  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
