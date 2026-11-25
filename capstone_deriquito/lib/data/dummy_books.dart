import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/models/genre.dart';
import 'package:capstone_deriquito/data/genres.dart';
 
final dummyBooks = [
  Book(
      id: 'a',
      title: 'Lapvona',
      author: 'Ottessa Moshfegh',
      genre: genres[Genres.darkFiction]!,
      description:
          "A dark and grotesque tale set in a medieval village. It follows a young boy whose life becomes tangled up with a cruel lord and a starving community, mixing dark humor, violence, and strange faith.",
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1648731442i/60725845.jpg'),
  Book(
      id: 'b',
      title: 'The Stranger',
      author: 'Albert Camus',
      genre: genres[Genres.absurdist]!,
      description:
          "Meursault, a detached clerk in French Algiers, attends his mother's funeral and soon after commits a killing on a sunlit beach. The story follows his trial, where society judges him as much for how he feels as for what he did.",
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1738704267i/49552.jpg'),
  Book(
      id: 'c',
      title: 'Metamorphosis',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!,
      description:
          "Gregor Samsa, a traveling salesman, wakes up one morning transformed into a giant insect. The story follows how his family and his job react as he slowly becomes a burden to everyone around him.",
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/1600964222-L.jpg?default=false'),
  Book(
      id: 'd',
      title: 'The Myth of Sisyphus',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!,
      description:
          "A philosophical essay that asks whether life is worth living in a world with no clear meaning. Camus uses the myth of Sisyphus, who must roll a boulder uphill forever, to argue that we can accept the absurd and still live fully.",
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780679733737-L.jpg?default=false'),
  Book(
      id: 'e',
      title: 'The Rebel',
      author: 'Albert Camus',
      genre: genres[Genres.philosophy]!,
      description:
          "An essay about rebellion and revolution. Camus asks when revolt is justified, shows how revolutions can slide into tyranny and violence, and argues for limits, moderation, and human solidarity.",
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1547122397i/11990.jpg'),
  Book(
      id: 'f',
      title: 'The Bell Jar',
      author: 'Sylvia Plath',
      genre: genres[Genres.literary]!,
      description:
          "Esther Greenwood, a talented young woman in 1950s America, spends a summer interning in New York and then begins to struggle with her mental health. A semi-autobiographical novel about ambition, the expectations placed on women, and finding a way back.",
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1668645154i/56616095.jpg'),
  Book(
      id: 'g',
      title: 'Coraline',
      author: 'Neil Gaiman',
      genre: genres[Genres.darkFantasy]!,
      description:
          "Coraline finds a hidden door in her family's new home that leads to a mirror version of her life, with 'other' parents who want to keep her forever. She has to use her courage and wits to escape.",
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780380807345-L.jpg?default=false'),
  Book(
      id: 'h',
      title: 'The Trial',
      author: 'Franz Kafka',
      genre: genres[Genres.absurdist]!,
      description:
          "Josef K. is arrested one morning by authorities who never tell him what he is accused of. He is pulled deeper into a confusing legal system, in a nightmare about guilt, bureaucracy, and power.",
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780805210408-L.jpg?default=false'),
  Book(
      id: 'i',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      genre: genres[Genres.gothic]!,
      description:
          "Dorian Gray, a handsome young man, wishes that his portrait would age instead of him. As he chases pleasure without consequences, the painting slowly shows the cost of his choices.",
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/0141439572-L.jpg?default=false'),
  Book(
      id: 'j',
      title: 'Bunny',
      author: 'Mona Awad',
      genre: genres[Genres.horrorComedy]!,
      description:
          "Samantha, a lonely scholarship student in an MFA writing program, gets pulled into a circle of wealthy classmates who all call each other 'Bunny'. Their strange rituals blur the line between reality and nightmare.",
      imageUrl:
          'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1588043687i/53285047.jpg'),
];