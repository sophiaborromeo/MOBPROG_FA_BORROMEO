import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

const double kSummaryPadding = 12;

class ReadingSummary extends StatelessWidget {
  const ReadingSummary({
    super.key,
    required this.books,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final totalBooks = books.length;
    final finishedBooks = books
        .where((book) => book.status == ReadingStatus.finished)
        .length;
    final currentlyReading = books
        .where((book) => book.status == ReadingStatus.reading)
        .length;
    final wantToRead = books
        .where((book) => book.status == ReadingStatus.wantToRead)
        .length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSummaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading Summary',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStat(
                    context,
                    'Total',
                    totalBooks.toString(),
                    Icons.menu_book,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    context,
                    'Reading',
                    currentlyReading.toString(),
                    Icons.auto_stories,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    context,
                    'Finished',
                    finishedBooks.toString(),
                    Icons.check_circle_outline,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    context,
                    'To Read',
                    wantToRead.toString(),
                    Icons.bookmark_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 26,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
