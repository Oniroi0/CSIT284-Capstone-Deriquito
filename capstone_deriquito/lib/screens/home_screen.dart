import 'package:flutter/material.dart';
import '../data/dummy_books.dart';
import '../widgets/book_card.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Borrowing Tracker')),
      body: ListView.builder(
        itemCount: dummyBooks.length,
        itemBuilder: (context, index) {
          return BookCard(book: dummyBooks[index]);
        },
      ),
    );
  }
}