import 'package:flutter/material.dart';
import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/widgets/book_cover.dart';
 
class BookDetailScreen extends StatelessWidget {
  final Book book;
 
  const BookDetailScreen({super.key, required this.book});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: BookCover(imageUrl: book.imageUrl, width: 160, height: 240),
          ),
          const SizedBox(height: 16),
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
    );
  }
}