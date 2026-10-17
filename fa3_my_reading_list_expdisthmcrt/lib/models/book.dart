import 'package:flutter/material.dart';

class Book {
  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.rating,
    required this.genre,
    required this.status,
  });

  final String title;
  final String author;
  final int pages;
  final int rating;
  final BookGenre genre;

  ReadingStatus status;
}

enum BookGenre {
  fiction,
  nonFiction,
  fantasy,
  biography,
  mystery,
  romance,
  scienceFiction,
  other,
}

enum ReadingStatus {
  wantToRead,
  reading,
  finished,
}

extension BookGenreLabel on BookGenre {
  String get label {
    switch (this) {
      case BookGenre.fiction:
        return 'Fiction';
      case BookGenre.nonFiction:
        return 'Non-fiction';
      case BookGenre.fantasy:
        return 'Fantasy';
      case BookGenre.biography:
        return 'Biography';
      case BookGenre.mystery:
        return 'Mystery';
      case BookGenre.romance:
        return 'Romance';
      case BookGenre.scienceFiction:
        return 'Science Fiction';
      case BookGenre.other:
        return 'Others';
    }
  }
}

extension ReadingStatusLabel on ReadingStatus {
  String get label {
    switch (this) {
      case ReadingStatus.wantToRead:
        return 'Want to Read';
      case ReadingStatus.reading:
        return 'Reading';
      case ReadingStatus.finished:
        return 'Finished';
    }
  }

  Color get color {
    switch (this) {
      case ReadingStatus.wantToRead:
        return const Color.fromARGB(255, 48, 1, 41);
      case ReadingStatus.reading:
        return const Color.fromARGB(255, 161, 25, 127);
      case ReadingStatus.finished:
        return const Color.fromARGB(255, 233, 137, 212);
    }
  }
}
