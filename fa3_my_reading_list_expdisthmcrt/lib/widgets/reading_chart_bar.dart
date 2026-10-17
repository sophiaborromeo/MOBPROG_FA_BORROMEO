import 'package:flutter/material.dart';

class ReadingChartBar extends StatelessWidget {
  final String label;
  final int count;
  final double fill;
  final IconData icon;

  const ReadingChartBar({
    super.key,
    required this.label,
    required this.count,
    required this.fill,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            Text(
              '$count',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 6),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: fill,
                  widthFactor: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: fill > 0
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Icon(
              icon,
              color: colorScheme.primary,
              size: 22,
            ),
            const SizedBox(height: 4),

            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
