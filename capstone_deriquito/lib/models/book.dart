import 'package:capstone_deriquito/models/genre.dart';
 
class Book {
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isBorrowed = false,
    this.dueDate,
  });
 
  final String id;
  final String title;
  final String author;
  final Genre genre;
  bool isBorrowed;
  DateTime? dueDate;
}