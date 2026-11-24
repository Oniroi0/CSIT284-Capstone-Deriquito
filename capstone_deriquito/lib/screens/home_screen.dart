import 'package:flutter/material.dart';
import 'package:capstone_deriquito/colors.dart';
import 'package:capstone_deriquito/data/dummy_books.dart';
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

  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Book> getFilteredBooks() {
    List<Book> result = [];
    String query = searchController.text.toLowerCase();

    for (Book book in dummyBooks) {
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

  void borrowBook(Book book) {
    setState(() {
      book.isBorrowed = true;
      book.dueDate = DateTime.now().add(const Duration(days: 7));
      history.insert(0, HistoryEntry(title: book.title, action: 'Borrowed'));
    });
  }

  void returnBook(Book book) {
    setState(() {
      book.isBorrowed = false;
      book.dueDate = null;
      history.insert(0, HistoryEntry(title: book.title, action: 'Returned'));
    });
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

  @override
  Widget build(BuildContext context) {
    List<Book> borrowedBooks = [];
    for (Book book in dummyBooks) {
      if (book.isBorrowed) {
        borrowedBooks.add(book);
      }
    }
    int availableCount = dummyBooks.length - borrowedBooks.length;

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
            Expanded(
              child: SingleChildScrollView(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}