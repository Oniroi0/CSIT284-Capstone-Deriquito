import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/book_detail_screen.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFE7DA),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF0F372B)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('${book.author} • ${book.genre.title}'),
        trailing: Text(
          book.isBorrowed ? 'Borrowed' : 'Available',
          style: TextStyle(
            color: book.isBorrowed
                ? const Color(0xFFE8392B)
                : const Color(0xFF0F372B),
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: book),
            ),
          );
        },
      ),
    );
  }
}