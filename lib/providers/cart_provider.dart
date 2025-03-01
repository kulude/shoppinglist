import 'package:myapp/models/data_model.dart';
import 'package:myapp/models/cart_model.dart';
class CartProvider {
  final List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.book.price * item.quantity));
  }

  void addToCart(Book book) {
    final existingIndex = _items.indexWhere((item) => item.book.id == book.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(book: book));
    }
  }

  void removeFromCart(Book book) {
    _items.removeWhere((item) => item.book.id == book.id);
  }

  void increaseQuantity(Book book) {
    final existingIndex = _items.indexWhere((item) => item.book.id == book.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    }
  }

  void decreaseQuantity(Book book) {
    final existingIndex = _items.indexWhere((item) => item.book.id == book.id);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
    }
  }

  void clearCart() {
    _items.clear();
  }
}
