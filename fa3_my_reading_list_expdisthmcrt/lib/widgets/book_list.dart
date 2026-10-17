import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';
import 'book_item.dart';

class BookList extends StatelessWidget {
  const BookList({super.key, required this.books, required this.onRemoveBook, required this.onUpdateStatus,});

  final List<Book> books;
  final void Function(Book book) onRemoveBook;
  final void Function(Book book, ReadingStatus status) onUpdateStatus;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 88,
      ),
      itemCount: books.length,
      itemBuilder: (ctx, index) {
        final book = books[index];

        return BookItem(
          key: ObjectKey(book),
          book: book,
          onRemoveBook: () => onRemoveBook(book),
          onUpdateStatus: (status) {
            onUpdateStatus(book, status);
          },
        );
      },
    );
  }
}
