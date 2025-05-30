class ProductModel {
  final String id;
  final String name;
  final String description;
  final String sellerName;
  final double price;
  final String avatar;
  final List<String> sizes;
  final List<String> colors;
  final String category;
  final int stock;
  final bool isAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.avatar,
    required this.sizes,
    required this.colors,
    required this.sellerName,
    required this.category,
    required this.stock,
    required this.isAvailable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sellerName: json['sellerName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      avatar: json['avatar'] ?? '',
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'avatar': avatar,
      'sellerName': sellerName,
      'colors': colors,
      'sizes': sizes,
      'category': category,
      'stock': stock,
      'isAvailable': isAvailable,
    };
  }
}
