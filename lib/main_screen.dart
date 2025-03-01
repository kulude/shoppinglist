import 'package:flutter/material.dart';
import 'package:myapp/providers/favorites_provider.dart';
import 'package:myapp/providers/cart_provider.dart';
import 'package:myapp/models/data_model.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/favorites_screen.dart';
import 'package:myapp/profile_screen.dart';
import 'package:myapp/cart_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final CartProvider _cartProvider = CartProvider();
  final FavoritesProvider _favoritesProvider = FavoritesProvider();
  
  // Sample book data
  final List<Book> _books = [
    Book(
      id: 1,
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      imageUrl: 'https://example.com/gatsby.jpg',
      price: 12.99,
      description: 'A classic novel about the American Dream.',
    ),
    Book(
      id: 2,
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      imageUrl: 'https://example.com/mockingbird.jpg',
      price: 10.99,
      description: 'A powerful story of racial injustice and moral growth.',
    ),
    Book(
      id: 3,
      title: '1984',
      author: 'George Orwell',
      imageUrl: 'https://example.com/1984.jpg',
      price: 9.99,
      description: 'A dystopian novel about totalitarianism.',
    ),
    Book(
      id: 4,
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      imageUrl: 'https://example.com/pride.jpg',
      price: 8.99,
      description: 'A romantic novel about manners and misconceptions.',
    ),
    Book(
      id: 5,
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      imageUrl: 'https://example.com/hobbit.jpg',
      price: 14.99,
      description: 'A fantasy novel about Bilbo Baggins and his adventures.',
    ),
  ];

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    // Initialize screens with providers
    _screens.addAll([
      HomeScreen(books: _books, cartProvider: _cartProvider, favoritesProvider: _favoritesProvider),
      FavoritesScreen(favoritesProvider: _favoritesProvider, cartProvider: _cartProvider),
      CartScreen(cartProvider: _cartProvider),
      ProfileScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Shop'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_cartProvider.items.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${_cartProvider.items.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              // Navigate to cart screen
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                'Book Shop Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to categories screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Trending Books'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to trending books screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.new_releases),
              title: const Text('New Releases'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to new releases screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to help screen
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
