class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final double rating;
  final String category;
  final String thumbnail;
  final bool inStock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.thumbnail,
    required this.inStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    price: json['price'],
    rating: (json['rating'] as num).toDouble(),
    category: json['category'],
    thumbnail: json['thumbnail'],
    inStock: json['stock'] > 0,
  );
}
