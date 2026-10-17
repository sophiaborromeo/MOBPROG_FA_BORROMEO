import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';


const double kChartHeight = 145;
const double kChartBarWidth = 36;

class ReadingChart extends StatelessWidget {
  const ReadingChart({
    super.key,
    required this.books,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final statusCounts = {
      for (final status in ReadingStatus.values)
        status: books.where((book) => book.status == status).length,
    };

    final maxCount = statusCounts.values.fold<int>(
      0,
      (previous, count) => count > previous ? count : previous,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading Status Chart',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: kChartHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: ReadingStatus.values.map((status) {
                  final count = statusCounts[status] ?? 0;
                  final barHeight = maxCount == 0
                      ? 0.0
                      : (count / maxCount) * 100;

                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          count.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: kChartBarWidth,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: status.color,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          status == ReadingStatus.wantToRead
                              ? 'To Read'
                              : status.label,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
