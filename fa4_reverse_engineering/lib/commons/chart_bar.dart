
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: fill,
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.primary
                : const Color(0xFFC99A91),
          ),
        ),
      ),
    );
  }
}
