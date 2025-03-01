import 'package:flutter/material.dart';
import 'package:myapp/providers/cart_provider.dart';
class CartScreen extends StatelessWidget {
  final CartProvider cartProvider;

  const CartScreen({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItems = cartProvider.items;
    final totalAmount = cartProvider.totalAmount;

    if (cartItems.isEmpty) {
      return const Center(
        child: Text(
          'Your cart is empty!',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    cartItems[i].book.title.substring(0, 1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              title: Text(cartItems[i].book.title),
              subtitle: Text('${cartItems[i].book.author} - \$${cartItems[i].book.price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cartProvider.decreaseQuantity(cartItems[i].book);
                    },
                  ),
                  Text('${cartItems[i].quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartProvider.increaseQuantity(cartItems[i].book);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItems[i].book);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Checkout process
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Proceeding to checkout...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'CHECKOUT',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
