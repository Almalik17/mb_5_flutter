import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Mandiri Pertemuan 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MainTabScreen(),
    );
  }
}

// ==================== MODEL DATA ====================
class Book {
  final String title;
  final String author;
  final String category;
  final String imageUrl;

  const Book(this.title, this.author, this.category, this.imageUrl);
}

// ==================== SCREEN UTAMA ====================
class MainTabScreen extends StatelessWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas Mandiri Pertemuan 5'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'ListView'),
              Tab(icon: Icon(Icons.grid_view), text: 'GridView'),
              Tab(icon: Icon(Icons.book), text: 'Books'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyListView(), // Tugas 1
            MyGridView(), // Tugas 2
            BookListView(), // Tugas 3 (Daftar Buku)
          ],
        ),
      ),
    );
  }
}

// ==================== WIDGET TUGAS 1 (ListView) ====================
class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Colors.primaries[index % Colors.primaries.length],
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text('Item ke-${index + 1}'),
            subtitle: const Text('Tampilan dengan CircleAvatar dinamis'),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}

// ==================== WIDGET TUGAS 2 (GridView) ====================
class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://picsum.photos/300/300?random=$index',
                fit: BoxFit.cover,
              ),
              Container(
                // PERBAIKAN: padding di luar BoxDecoration
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gallery ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==================== WIDGET TUGAS 3 (Daftar Buku) ====================
class BookListView extends StatelessWidget {
  const BookListView({super.key});

  static const List<Book> books = [
    Book(
      "Atomic Habits",
      "James Clear",
      "Self-Improvement",
      "https://picsum.photos/id/20/400/300",
    ),
    Book(
      "Psychology of Money",
      "Morgan Housel",
      "Finance",
      "https://picsum.photos/id/237/400/300",
    ),
    Book(
      "Clean Code",
      "Robert C. Martin",
      "Programming",
      "https://picsum.photos/id/180/400/300",
    ),
    Book(
      "The Alchemist",
      "Paulo Coelho",
      "Fiction",
      "https://picsum.photos/id/251/400/300",
    ),
    Book(
      "Dune",
      "Frank Herbert",
      "Sci-Fi",
      "https://picsum.photos/id/133/400/300",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.imageUrl,
                    width: 80,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 80,
                      height: 110,
                      color: Colors.grey[300],
                      child: const Icon(Icons.book),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by ${book.author}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          book.category,
                          style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.favorite_border, color: Colors.red),
              ],
            ),
          ),
        );
      },
    );
  }
}
