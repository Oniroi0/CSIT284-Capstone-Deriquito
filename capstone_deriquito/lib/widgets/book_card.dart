import 'package:flutter/material.dart';
import '../models/book.dart';
 
class BookCard extends StatelessWidget {
  final Book book;
 
  const BookCard({super.key, required this.book});
 
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('${book.author} • ${book.genre.title}'),
        trailing: Text(book.isBorrowed ? 'Borrowed' : 'Available'),
      ),
    );
  }
}