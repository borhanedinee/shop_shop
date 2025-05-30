// ----------------- core/widgets/cart_item_widget.dart -----------------
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/widgets/cart_screen/cart_item_widget.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Get.find<CartController>().fetchCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => GetBuilder<CartController>(
              builder:
                  (controller) => Container(
                    height: constraints.maxHeight,
                    child:
                        controller.isFetchingCartItems
                            ? Center(
                              child: SpinKitFadingCircle(
                                color: AppColors.primaryColor,
                                size: 50.0,
                              ),
                            )
                            : controller.cartItems.isEmpty
                            ? _empty_cart()
                            : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GetBuilder<CartController>(
                                    builder:
                                        (controller) => ListView.builder(
                                          itemCount:
                                              controller.cartItems.length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                controller.cartItems[index];
                                            return GestureDetector(
                                              onTap: () {
                                                // Get.to(ProductDetailScreen(item: item));
                                              },
                                              child: CartItemWidget(
                                                item: item,
                                                onRemove: () {
                                                  controller.removeFromCart(
                                                    item.productId,
                                                  );
                                                  controller.update();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('SUBTOTAL:'),
                                            Text(
                                              '${Get.find<CartController>().cartItems.fold(0.0, (sum, item) => sum + item.price).toStringAsFixed(2)} DA',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Delivery Fee:'),
                                            Text(
                                              '300 DA',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('DISCOUNT:'),
                                            Text(
                                              '40%',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 32),
                                        MyButton(
                                          onPressed: () {
                                            Get.snackbar(
                                              'Success',
                                              'Purchase completed!',
                                            );
                                          },
                                          child: const Text(
                                            'Buy now',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  ),
            ),
      ),
    );
  }

  Center _empty_cart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          // Main Message
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          // Suggestion Text
          Text(
            'Add some products to get started!',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
