import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/models/genre.dart';
import 'package:capstone_deriquito/data/genres.dart';
 
final dummyBooks = [
  Book(
      id: 'a',
      title: 'Lapvona',
      author: 'Ottessa Moshfegh',
      genre: genres[Genres.darkFiction]!,
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1648731442i/60725845.jpg'),
  Book(
      id: 'b',
      title: 'The Stranger',
      author: 'Albert Camus',
      genre: genres[Genres.absurdist]!,
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1738704267i/49552.jpg'),
  Book(
      id: 'c',
      title: 'Metamorphosis',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/1600964222-L.jpg?default=false'),
  Book(
      id: 'd',
      title: 'The Myth of Sisyphus',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780679733737-L.jpg?default=false'),
  Book(
      id: 'e',
      title: 'The Rebel',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!,
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1547122397i/11990.jpg'),
  Book(
      id: 'f',
      title: 'The Bell Jar',
      author: 'Sylvia Plath',
      genre: genres[Genres.literary]!,
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1668645154i/56616095.jpg'),
  Book(
      id: 'g',
      title: 'Coraline',
      author: 'Neil Gaiman',
      genre: genres[Genres.darkFantasy]!,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780380807345-L.jpg?default=false'),
  Book(
      id: 'h',
      title: 'The Trial',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780805210408-L.jpg?default=false'),
  Book(
      id: 'i',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      genre: genres[Genres.gothic]!,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/0141439572-L.jpg?default=false'),
  Book(
      id: 'j',
      title: 'Bunny',
      author: 'Mona Awad',
      genre: genres[Genres.horrorComedy]!,
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1588043687i/53285047.jpg'),
];