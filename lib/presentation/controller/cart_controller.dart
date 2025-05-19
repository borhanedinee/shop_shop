import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:deels_here/domain/repositories/cart_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartRepositoryImpl cartRepo;
  CartController(this.cartRepo);

  List<CartItemModel> cardProducts = [];

  getCardProducts() {
    cardProducts = cartRepo.getCartItems();
    update();
  }
}
