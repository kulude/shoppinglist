import 'package:myapp/models/data_model.dart';
class FavoritesProvider {
  final List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks {
    return [..._favoriteBooks];
  }

  bool isFavorite(Book book) {
    return _favoriteBooks.any((item) => item.id == book.id);
  }

  void addToFavorites(Book book) {
    if (!isFavorite(book)) {
      _favoriteBooks.add(book);
    }
  }

  void removeFromFavorites(Book book) {
    _favoriteBooks.removeWhere((item) => item.id == book.id);
  }
}
