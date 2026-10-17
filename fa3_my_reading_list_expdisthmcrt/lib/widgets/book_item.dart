import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    super.key,
    required this.book,
    required this.onRemoveBook,
    required this.onUpdateStatus,
  });

  final Book book;
  final VoidCallback onRemoveBook;
  final ValueChanged<ReadingStatus> onUpdateStatus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: onRemoveBook,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Remove Book',
                  color: colorScheme.error,
                ),
              ],
            ),

            Text(
              'by ${book.author}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildDetail(
                  context,
                  Icons.auto_stories,
                  '${book.pages} pages',
                ),
                _buildDetail(
                  context,
                  Icons.category_outlined,
                  book.genre.label,
                ),
                _buildDetail(
                  context,
                  Icons.star,
                  '${book.rating}/5',
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.bookmark_outline, size: 15),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<ReadingStatus>(
                    value: book.status,
                    isExpanded: true,
                    isDense: true,
                    underline: const SizedBox.shrink(),
                    items: ReadingStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                    onChanged: (status) {
                      if (status != null) {
                        onUpdateStatus(status);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
