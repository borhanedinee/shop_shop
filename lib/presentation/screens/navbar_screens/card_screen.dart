// presentation/screens/cart_screen.dart
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/widgets/cart_screen/cart_item_widget.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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
      body: SingleChildScrollView(
        child: GetBuilder<CartController>(
          builder:
              (controller) =>
                  controller.isFetchingCartItems
                      ? Column(
                        children: [
                          const SizedBox(height: 400),
                          Center(
                            child: SpinKitFadingCircle(
                              color: AppColors.primaryColor,
                              size: 50.0,
                            ),
                          ),
                        ],
                      )
                      : controller.cartItems.isEmpty
                      ? _emptyCart()
                      : Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Cart',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GetBuilder<CartController>(
                            builder:
                                (controller) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  itemCount: controller.cartItems.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.cartItems[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Get.to(ProductDetailScreen(item: item));
                                        },
                                        child: CartItemWidget(
                                          item: item,
                                          onRemove: () {
                                            controller.removeFromCart(
                                              item.cartItemId,
                                            );
                                            controller.update();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildSummaryRow(
                                  'SUBTOTAL:',
                                  '${controller.cartItems.fold(0.0, (sum, item) => sum + item.price).toInt()} DA',
                                ),
                                const SizedBox(height: 8),
                                _buildSummaryRow('Delivery Fee:', '300 DA'),
                                const SizedBox(height: 8),
                                _buildSummaryRow('DISCOUNT:', '40%'),
                                const SizedBox(height: 24),
                                MyButton(
                                  onPressed: () {
                                    Get.snackbar(
                                      'Success',
                                      'Purchase completed!',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: AppColors.primaryColor,
                                      colorText: Colors.white,
                                    );
                                  },
                                  child: const Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 300),
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
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
