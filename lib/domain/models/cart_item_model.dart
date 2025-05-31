class CartItem {
  final String cartItemId;
  final String name;
  final int price;
  final int quantity;
  final String avatar;
  final String size;
  final String color;

  CartItem({
    required this.cartItemId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.avatar,
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': cartItemId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'avatar': avatar,
      'size': size,
      'color': color,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      avatar: json['avatar'],
      size: json['size'],
      color: json['color'],
    );
  }
}
