// presentation/screens/category_items_screen.dart
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/domain/models/product_model.dart';
import 'package:deels_here/presentation/controller/home_controller.dart';
import 'package:deels_here/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({super.key, required this.catLabel});

  final String catLabel;

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch products by category when the widget is built
      print('Fetching products for category: ${widget.catLabel}');
      controller.fetchProductsByCategory(widget.catLabel);
    });
    super.initState();
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(item: product));
      },
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${product.price.toInt()} DA',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyProducts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No items found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different category or check back later!',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String category =
        widget.catLabel; // Use the passed catLabel instead of Get.arguments

    return Scaffold(
      appBar: AppBar(title: Text('Items in $category')),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.isFetchingProducts) {
            return const Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (controller.productsToDisplay.isEmpty) {
            return _emptyProducts();
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.productsToDisplay.length,
              itemBuilder: (context, index) {
                return _buildProductCard(controller.productsToDisplay[index]);
              },
            );
          }
        },
      ),
    );
  }
}
