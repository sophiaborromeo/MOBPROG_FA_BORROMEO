import 'package:fa3_my_reading_list_expdisthmcrt/main.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/widgets/book_list.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/widgets/new_book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/widgets/reading_chart.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/widgets/reading_summary.dart';
import 'package:flutter/material.dart';


class ReadingListScreen extends StatefulWidget {
  const ReadingListScreen({super.key});

  @override
  State<ReadingListScreen> createState() => _ReadingListScreenState();
}

class _ReadingListScreenState extends State<ReadingListScreen> {
  final List<Book> _books = [];

  void _openAddBookForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewBook(
          onAddBook: _addBook,
        );
      },
    );
  }

  void _addBook(Book book) {
    setState(() {
      _books.add(book);
    });
  }

  void _removeBook(Book book) {
    setState(() {
      _books.remove(book);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kSeedColor,
        content: Text('"${book.title}" removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _books.add(book);
            });
          },
        ),
      ),
    );
  }

  void _updateBookStatus(Book book, ReadingStatus status) {
    setState(() {
      book.status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Reading List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddBookForm,
        icon: const Icon(Icons.menu_book),
        label: const Text('Add Book'),
      ),

      body: _books.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                ReadingSummary(books: _books),
                ReadingChart(books: _books),
                Expanded(
                  child: BookList(
                    books: _books,
                    onRemoveBook: _removeBook,
                    onUpdateStatus: _updateBookStatus,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Hey, bookworm! Your reading list is currently empty.',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Start tracking your reading progress!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openAddBookForm,
              icon: const Icon(Icons.add),
              label: const Text('Add My First Book'),
            ),
          ],
        ),
      ),
    );
  }
}
