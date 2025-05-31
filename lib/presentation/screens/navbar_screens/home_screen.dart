// presentation/screens/navbar_screens/home_screen.dart
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/domain/models/product_model.dart';
import 'package:deels_here/presentation/controller/home_controller.dart';
import 'package:deels_here/presentation/screens/others_categories_screen.dart';
import 'package:deels_here/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.find<HomeController>().fetchProducts();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => GetBuilder<HomeController>(
              builder:
                  (controller) => SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          // Search Bar
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  controller.productsToDisplay =
                                      controller.allProducts;
                                } else {
                                  controller.filterSearchedProducts(value);
                                }
                                controller.update();
                              },
                              decoration: InputDecoration(
                                suffixIcon:
                                    searchController.text == ''
                                        ? null
                                        : IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            searchController.clear();
                                            controller.productsToDisplay =
                                                controller.allProducts;
                                            controller.update();
                                          },
                                        ),
                                hintText: 'Search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          // Category Filters
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildCategoryChip(
                                  'All',
                                  isSelected:
                                      controller.selectedCategory == 'All',
                                ),
                                _buildCategoryChip(
                                  'Clothing',
                                  isSelected:
                                      controller.selectedCategory == 'Clothing',
                                ),
                                _buildCategoryChip(
                                  'Footwear',
                                  isSelected:
                                      controller.selectedCategory == 'Footwear',
                                ),
                                _buildCategoryChip('Other'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Popular Section
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Popular',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Product Grid
                          GetBuilder<HomeController>(
                            builder:
                                (controller) =>
                                    controller.isFetchingProducts
                                        ? Column(
                                          children: [
                                            const SizedBox(height: 200),
                                            const Center(
                                              child: SpinKitFadingCircle(
                                                color: AppColors.primaryColor,
                                                size: 50.0,
                                              ),
                                            ),
                                          ],
                                        )
                                        : controller.productsToDisplay.isEmpty
                                        ? _emptyProducts()
                                        : GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(8.0),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.75,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 8,
                                              ),
                                          itemCount:
                                              controller
                                                  .productsToDisplay
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final product =
                                                controller
                                                    .productsToDisplay[index];
                                            return _buildProductCard(product);
                                          },
                                        ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
            ),
      ),
    );
  }

  Center _emptyProducts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or check back later!',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        final controller = Get.find<HomeController>();
        if (label == 'All') {
          controller.selectedCategory = 'All';
          controller.productsToDisplay = controller.allProducts;
          controller.update();
          return;
        }

        if (label == 'Other') {
          controller.selectedCategory = 'All';
          controller.productsToDisplay = controller.allProducts;
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => OthersStoresScreen()));
          controller.update();

          return;
        }

        controller.selectedCategory = label;
        controller.fetchProductsByCategory(label);
        controller.update();
      },
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.purple[100] : Colors.grey[200],
        labelStyle: TextStyle(color: isSelected ? Colors.purple : Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(item: product),
          ),
        );
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
}
