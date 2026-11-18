import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/models/genre.dart';
import 'package:capstone_deriquito/data/genres.dart';
 
final dummyBooks = [
  Book(
      id: 'a',
      title: 'Lapvona',
      author: 'Ottessa Moshfegh',
      genre: genres[Genres.darkFiction]!),
  Book(
      id: 'b',
      title: 'The Stranger',
      author: 'Albert Camus',
      genre: genres[Genres.absurdist]!),
  Book(
      id: 'c',
      title: 'Metamorphosis',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!),
  Book(
      id: 'd',
      title: 'The Myth of Sisyphus',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!),
  Book(
      id: 'e',
      title: 'The Rebel',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!),
  Book(
      id: 'f',
      title: 'The Bell Jar',
      author: 'Sylvia Plath',
      genre: genres[Genres.literary]!),
  Book(
      id: 'g',
      title: 'Coraline',
      author: 'Neil Gaiman',
      genre: genres[Genres.darkFantasy]!),
  Book(
      id: 'h',
      title: 'The Trial',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!),
  Book(
      id: 'i',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      genre: genres[Genres.gothic]!),
  Book(
      id: 'j',
      title: 'Bunny',
      author: 'Mona Awad',
      genre: genres[Genres.horrorComedy]!),
];