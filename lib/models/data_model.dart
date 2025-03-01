class Book {
  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });
}
