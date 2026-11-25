import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_deriquito/colors.dart';
import 'package:capstone_deriquito/data/dummy_books.dart';
import 'package:capstone_deriquito/data/firebase_url.dart';
import 'package:capstone_deriquito/data/genres.dart';
import 'package:capstone_deriquito/models/book.dart';
import 'package:capstone_deriquito/models/history_entry.dart';
import 'package:capstone_deriquito/widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String filter = 'All';
  List<HistoryEntry> history = [];
  List<Book> allBooks = [];
  bool isLoading = true;
  String? error;

  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadBooks() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final url = Uri.https(firebaseHost, 'books.json');
      final response = await http.get(url);
      if (!mounted) return;

      if (response.statusCode >= 400) {
        setState(() {
          error = 'Failed to load books. Please try again later.';
          isLoading = false;
        });
        return;
      }

      if (response.body == 'null') {
        await seedBooks();
        return;
      }

      final Map<String, dynamic> data = json.decode(response.body);
      List<Book> loadedBooks = [];

      for (final item in data.entries) {
        final map = item.value;
        final genre = genres.values.firstWhere((g) => g.title == map['genre']);

        DateTime? dueDate;
        if (map['dueDate'] != null) {
          dueDate = DateTime.parse(map['dueDate']);
        }

        loadedBooks.add(
          Book(
            id: item.key,
            title: map['title'],
            author: map['author'],
            genre: genre,
            description: map['description'],
            imageUrl: map['imageUrl'],
            isBorrowed: map['isBorrowed'] ?? false,
            dueDate: dueDate,
          ),
        );
      }

      setState(() {
        allBooks = loadedBooks;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Something went wrong. Please try again later.';
        isLoading = false;
      });
    }
  }

  Future<void> seedBooks() async {
    for (final book in dummyBooks) {
      final url = Uri.https(firebaseHost, 'books/${book.id}.json');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(book.toMap()),
      );

      if (response.statusCode >= 400) {
        if (!mounted) return;
        setState(() {
          error = 'Failed to save the starting books. Check your Firebase rules.';
          isLoading = false;
        });
        return;
      }
    }
    await loadBooks();
  }

  Future<bool> saveBookStatus(
    Book book,
    bool isBorrowed,
    DateTime? dueDate,
  ) async {
    final url = Uri.https(firebaseHost, 'books/${book.id}.json');
    final response = await http.patch(
      url,
      body: json.encode({
        'isBorrowed': isBorrowed,
        'dueDate': dueDate?.toIso8601String(),
      }),
    );
    return response.statusCode < 400;
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> borrowBook(Book book) async {
    final dueDate = DateTime.now().add(const Duration(days: 7));
    final saved = await saveBookStatus(book, true, dueDate);
    if (!mounted) return;

    if (!saved) {
      showMessage('Could not borrow the book. Please try again.');
      return;
    }

    setState(() {
      book.isBorrowed = true;
      book.dueDate = dueDate;
      history.insert(0, HistoryEntry(title: book.title, action: 'Borrowed'));
    });
  }

  Future<void> returnBook(Book book) async {
    final saved = await saveBookStatus(book, false, null);
    if (!mounted) return;

    if (!saved) {
      showMessage('Could not return the book. Please try again.');
      return;
    }

    setState(() {
      book.isBorrowed = false;
      book.dueDate = null;
      history.insert(0, HistoryEntry(title: book.title, action: 'Returned'));
    });
  }

  List<Book> getFilteredBooks() {
    List<Book> result = [];
    String query = searchController.text.toLowerCase();

    for (Book book in allBooks) {
      bool matchesSearch = book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      bool matchesFilter = true;
      if (filter == 'Available') matchesFilter = !book.isBorrowed;
      if (filter == 'Borrowed') matchesFilter = book.isBorrowed;

      if (matchesSearch && matchesFilter) {
        result.add(book);
      }
    }
    return result;
  }

  void resetFilters() {
    setState(() {
      searchController.clear();
      filter = 'All';
    });
  }

  Widget panel(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bone,
        border: Border.all(color: lineColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: mutedGreen,
      ),
    );
  }

  Widget counter(String label, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 11, color: mutedGreen),
        ),
      ],
    );
  }

  Widget buildCatalog() {
    List<Book> books = getFilteredBooks();

    return panel(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionLabel('Book catalog'),
          const SizedBox(height: 12),
          TextField(
            controller: searchController,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search by title or author...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => searchController.clear()),
                    ),
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (String name in ['All', 'Available', 'Borrowed'])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(name),
                    selected: filter == name,
                    onSelected: (selected) => setState(() => filter = name),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (books.isEmpty)
            Center(
              child: Column(
                children: [
                  const Text('No books match your search.'),
                  TextButton(
                    onPressed: resetFilters,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              Book book = books[index];
              return BookCard(
                book: book,
                onBorrow: () => borrowBook(book),
                onReturn: () => returnBook(book),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildLedger(List<Book> borrowedBooks) {
    return panel(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionLabel('Active loans'),
          const SizedBox(height: 8),
          if (borrowedBooks.isEmpty)
            const Text(
              'No books currently borrowed',
              style: TextStyle(color: mutedGreen),
            ),
          for (Book book in borrowedBooks)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Due ${months[book.dueDate!.month - 1]} ${book.dueDate!.day}',
                          style: const TextStyle(color: mutedGreen),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => returnBook(book),
                    style: OutlinedButton.styleFrom(foregroundColor: mutedGreen),
                    child: const Text('Return'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          const Divider(color: lineColor),
          const SizedBox(height: 12),
          sectionLabel('History'),
          const SizedBox(height: 8),
          if (history.isEmpty)
            const Text('No history yet', style: TextStyle(color: mutedGreen)),
          for (HistoryEntry entry in history.take(10))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('${entry.action} "${entry.title}" • Today'),
            ),
        ],
      ),
    );
  }

  Widget buildBody(List<Book> borrowedBooks) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error!),
            TextButton(
              onPressed: loadBooks,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 65, child: buildCatalog()),
                const SizedBox(width: 16),
                Expanded(flex: 35, child: buildLedger(borrowedBooks)),
              ],
            );
          }
          return Column(
            children: [
              buildCatalog(),
              const SizedBox(height: 16),
              buildLedger(borrowedBooks),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Book> borrowedBooks = [];
    for (Book book in allBooks) {
      if (book.isBorrowed) {
        borrowedBooks.add(book);
      }
    }
    int availableCount = allBooks.length - borrowedBooks.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: bone,
                border: Border(bottom: BorderSide(color: lineColor)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Book Borrowing Tracker',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Simple local catalog & borrowing ledger',
                        style: TextStyle(color: mutedGreen),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      counter('Available', availableCount),
                      const SizedBox(width: 20),
                      counter('Borrowed', borrowedBooks.length),
                      const SizedBox(width: 20),
                      counter('History', history.length),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: buildBody(borrowedBooks)),
          ],
        ),
      ),
    );
  }
}