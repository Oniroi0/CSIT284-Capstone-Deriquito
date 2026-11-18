import 'package:flutter/material.dart';
import '../models/book.dart';
 
class BookDetailScreen extends StatelessWidget {
  final Book book;
 
  const BookDetailScreen({super.key, required this.book});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Author: ${book.author}'),
            Text('Genre: ${book.genre.title}'),
            Text('Status: ${book.isBorrowed ? 'Borrowed' : 'Available'}'),
          ],
        ),
      ),
    );
  }
}