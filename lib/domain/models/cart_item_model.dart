// ----------------- data/models/cart_item_model.dart -----------------
class CartItemModel {
  final String id;
  final String name;
  final String size;
  final int quantity;
  final double price;

  CartItemModel({
    required this.id,
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'size': size,
    'quantity': quantity,
    'price': price,
  };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    id: json['id'],
    name: json['name'],
    size: json['size'],
    quantity: json['quantity'],
    price: json['price'].toDouble(),
  );
}
