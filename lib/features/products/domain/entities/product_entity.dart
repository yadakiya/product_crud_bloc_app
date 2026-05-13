class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}
