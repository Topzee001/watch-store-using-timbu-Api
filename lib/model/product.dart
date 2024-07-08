class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List<dynamic>?;
    final imageUrl = (photos != null && photos.isNotEmpty)
        ? 'https://api.timbu.cloud/images/${photos[0]['url']}'
        : '';
    final price = json['current_price']?[0]['USD']?[0]?.toDouble() ?? 0.0;

    return Product(
      id: json['id'],
      name: json['name'] ?? 'Unknown Watch',
      imageUrl: imageUrl,
      price: price,
    );
  }
}
