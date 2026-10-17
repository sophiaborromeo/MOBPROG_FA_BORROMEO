import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

const int kMinimumPages = 1;
const int kMaximumRating = 5;
const int kMinimumRating = 1;

class NewBook extends StatefulWidget {
  const NewBook({
    super.key,
    required this.onAddBook,
  });

  final void Function(Book book) onAddBook;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();

  BookGenre _selectedGenre = BookGenre.other;
  ReadingStatus _selectedStatus = ReadingStatus.wantToRead;
  int _selectedRating = 5;

  void _submitBook() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final book = Book(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: int.parse(_pagesController.text.trim()),
      rating: _selectedRating,
      genre: _selectedGenre,
      status: _selectedStatus,
    );

    widget.onAddBook(book);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a Book',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                  prefixIcon: Icon(Icons.menu_book),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the book title.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _authorController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the author.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _pagesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Pages',
                  prefixIcon: Icon(Icons.auto_stories),
                ),
                validator: (value) {
                  final pages = int.tryParse(value?.trim() ?? '');

                  if (pages == null || pages < kMinimumPages) {
                    return 'Enter a valid page count (at least 1).';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                initialValue: _selectedRating,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  prefixIcon: Icon(Icons.star),
                ),
                items: List.generate(
                  kMaximumRating,
                  (index) {
                    final rating = index + kMinimumRating;

                    return DropdownMenuItem(
                      value: rating,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 8),
                          Text('$rating / $kMaximumRating'),
                        ],
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedRating = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<BookGenre>(
                initialValue: _selectedGenre,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  prefixIcon: Icon(Icons.category),
                ),
                items: BookGenre.values.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedGenre = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<ReadingStatus>(
                initialValue: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Reading Status',
                  prefixIcon: Icon(Icons.bookmark_outline),
                ),
                items: ReadingStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedStatus = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _submitBook,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Book'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
