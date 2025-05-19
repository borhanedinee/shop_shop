import 'package:deels_here/domain/models/cart_item_model.dart';

class CartRepositoryImpl {
  List<CartItemModel> getCartItems() {
    // Updated dummy data based on the image
    return [
      CartItemModel(
        id: '1',
        name: 'Standard fit pants',
        size: 'M',
        quantity: 1,
        price: 2600.00,
      ),
      CartItemModel(
        id: '2',
        name: 'Oversized t-shirt',
        size: 'XL',
        quantity: 1,
        price: 3600.00,
      ),
      CartItemModel(
        id: '3',
        name: 'Denim jacket',
        size: 'S',
        quantity: 1,
        price: 5800.00,
      ),
      CartItemModel(
        id: '4',
        name: 'Spring sport wear',
        size: 'S',
        quantity: 1,
        price:
            16000.00, // Adjusted to match subtotal of $81.00 (12.00 + 32.65 + 22.45 + 14.90)
      ),
    ];
  }
}
