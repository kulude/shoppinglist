import 'package:flutter/material.dart';
import 'package:myapp/models/data_model.dart';
import 'package:myapp/providers/cart_provider.dart';
import 'package:myapp/providers/favorites_provider.dart';

class BookItem extends StatefulWidget {
  final Book book;
  final CartProvider cartProvider;
  final FavoritesProvider favoritesProvider;

  const BookItem({
    super.key,
    required this.book,
    required this.cartProvider,
    required this.favoritesProvider,
  });

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(widget.book.title, textAlign: TextAlign.center),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.favoritesProvider.isFavorite(widget.book)) {
                        widget.favoritesProvider.removeFromFavorites(
                          widget.book,
                        );
                      } else {
                        widget.favoritesProvider.addToFavorites(widget.book);
                      }
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 15,
                    child: Icon(
                      widget.favoritesProvider.isFavorite(widget.book)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.book.author,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.book.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.cartProvider.addToCart(widget.book);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.book.title} added to cart!',
                              textAlign: TextAlign.center,
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 14,
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
