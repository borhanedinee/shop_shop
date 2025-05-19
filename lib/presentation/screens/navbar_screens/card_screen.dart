// ----------------- core/widgets/cart_item_widget.dart -----------------
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:deels_here/domain/repositories/cart_repo.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/screens/product_details_screen.dart';
import 'package:deels_here/presentation/widgets/cart_screen/cart_item_widget.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController controller = Get.put(
    CartController(CartRepositoryImpl()),
  );

  @override
  void initState() {
    controller.getCardProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cart', style: TextStyle(fontSize: 24)),
                  ),
                  Expanded(
                    child: GetBuilder<CartController>(
                      builder:
                          (controller) => ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final item = controller.cardProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(ProductDetailScreen(item: item));
                                },
                                child: CartItemWidget(
                                  item: item,
                                  onRemove: () {
                                    controller.cardProducts.removeAt(index);
                                    controller.update();
                                  },
                                ),
                              );
                            },
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('SUBTOTAL:'),
                            Text(
                              '\$${controller.cardProducts.fold(0.0, (sum, item) => sum + item.price).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fee:'),
                            Text(
                              '\$5.00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DISCOUNT:'),
                            Text(
                              '40%',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onPressed: () {
                              Get.snackbar('Success', 'Purchase completed!');
                            },
                            child: const Text(
                              'Buy now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
