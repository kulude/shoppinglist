import 'package:flutter/material.dart';
import 'package:myapp/providers/favorites_provider.dart';
import 'package:myapp/providers/cart_provider.dart';
class FavoritesScreen extends StatelessWidget {
  final FavoritesProvider favoritesProvider;
  final CartProvider cartProvider;

  const FavoritesScreen({
    Key? key,
    required this.favoritesProvider,
    required this.cartProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = favoritesProvider.favoriteBooks;

    if (favoriteBooks.isEmpty) {
      return const Center(
        child: Text(
          'No favorites yet!',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: favoriteBooks.length,
      itemBuilder: (ctx, i) => ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              favoriteBooks[i].title.substring(0, 1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(favoriteBooks[i].title),
        subtitle: Text(favoriteBooks[i].author),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${favoriteBooks[i].price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                cartProvider.addToCart(favoriteBooks[i]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${favoriteBooks[i].title} added to cart!',
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                favoritesProvider.removeFromFavorites(favoriteBooks[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
