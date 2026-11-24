import 'package:flutter/material.dart';
import 'package:capstone_deriquito/colors.dart';
import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/screens/book_detail_screen.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.onBorrow,
    required this.onReturn,
  });

  final Book book;
  final VoidCallback onBorrow;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    String badgeText = 'Available';
    Color badgeColor = softGreen;
    Color badgeTextColor = bottleGreen;

    if (book.isBorrowed) {
      if (book.dueDate!.isBefore(DateTime.now())) {
        badgeText = 'Overdue';
        badgeColor = vermilion;
        badgeTextColor = bone;
      } else {
        final hoursLeft = book.dueDate!.difference(DateTime.now()).inHours;
        final daysLeft = (hoursLeft / 24).ceil();
        badgeText = 'Due in ${daysLeft}d';
        badgeColor = softVermilion;
        badgeTextColor = vermilion;
      }
    }

    return Card(
      color: bone,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: lineColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          book.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.author, style: const TextStyle(color: mutedGreen)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: badgeTextColor,
                ),
              ),
            ),
          ],
        ),
        trailing: book.isBorrowed
            ? OutlinedButton(
                onPressed: onReturn,
                style: OutlinedButton.styleFrom(foregroundColor: mutedGreen),
                child: const Text('Return'),
              )
            : FilledButton(
                onPressed: onBorrow,
                child: const Text('Borrow'),
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