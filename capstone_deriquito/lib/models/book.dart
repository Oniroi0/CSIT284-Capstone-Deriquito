import 'package:capstone_deriquito/models/genre.dart';
 
class Book {
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    this.imageUrl,
    this.isBorrowed = false,
    this.dueDate,
  });
 
  final String id;
  final String title;
  final String author;
  final Genre genre;
  final String description;
  final String? imageUrl;
  bool isBorrowed;
  DateTime? dueDate;
 
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'genre': genre.title,
      'description': description,
      'imageUrl': imageUrl,
      'isBorrowed': isBorrowed,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}