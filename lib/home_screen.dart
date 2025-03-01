import 'package:flutter/material.dart';
import 'package:myapp/providers/favorites_provider.dart';
import 'package:myapp/providers/cart_provider.dart';
import 'package:myapp/models/data_model.dart';
import 'package:myapp/book_item.dart';
class HomeScreen extends StatelessWidget {
  final List<Book> books;
  final CartProvider cartProvider;
  final FavoritesProvider favoritesProvider;

  const HomeScreen({
    Key? key,
    required this.books,
    required this.cartProvider,
    required this.favoritesProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (ctx, i) => BookItem(
        book: books[i],
        cartProvider: cartProvider,
        favoritesProvider: favoritesProvider,
      ),
    );
  }
}
