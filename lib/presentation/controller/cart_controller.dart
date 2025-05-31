import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:deels_here/main.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartItem> cartItems = <CartItem>[];

  bool isFetchingCartItems = false;
  Future<void> fetchCartItems() async {
    try {
      isFetchingCartItems = true;
      update(); // Notify listeners that fetching has started

      final userId = currentUser!.id;

      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('cart')
              .get();

      cartItems =
          snapshot.docs.map((doc) {
            print('Cart items fetched hh: ${doc.id}');
            final data = doc.data();
            data['productId'] = doc.id; // Ensure productId is set from doc ID
            return CartItem.fromJson(data);
          }).toList();
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Failed to fetch cart items: $e",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      isFetchingCartItems = false;
      update(); // Notify listeners that fetching has completed
    }
  }

  bool isAddingToCart = false;
  Future<void> addToCart(CartItem item) async {
    try {
      isAddingToCart = true;
      update();
      final userId = currentUser!.id;

      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(item.cartItemId); // 1 product per doc

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // If already exists, increase quantity
        await docRef.update({'quantity': FieldValue.increment(item.quantity)});
      } else {
        print(
          'docSnapshot does not exist, creating new with ${item.toJson()}...',
        );
        await docRef.set(item.toJson());
      }

      Get.showSnackbar(
        GetSnackBar(
          title: "Success",
          message: "Item added to cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Failed to add item to cart: $e",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      isAddingToCart = false;
      update(); // Notify listeners that adding has completed
    }
  }

  Future<void> removeFromCart(String cardDoc) async {
    try {
      final userId = currentUser!.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cardDoc)
          .delete();

      // Optionally update local state if you're using RxList
      cartItems.removeWhere((item) => item.cartItemId == cardDoc);

      Get.showSnackbar(
        GetSnackBar(
          title: "Success",
          message: "Item removed from cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
      update(); // Notify listeners that removal has completed
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Failed to remove item from cart: $e",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
