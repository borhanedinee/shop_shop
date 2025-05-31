// presentation/screens/navbar_screens/others_stores_screen.dart
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/screens/cateory_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OthersStoresScreen extends StatelessWidget {
  OthersStoresScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Clothing',
      'description': 'Explore the latest fashion trends.',
      'image': 'assets/images/clothing_store.jpg',
      'rating': 4.3,
      'category': 'clothing',
    },
    {
      'name': 'Footwear',
      'description': 'Find the perfect pair of shoes.',
      'image': 'assets/images/footwear_store.jpg',
      'rating': 4.1,
      'category': 'footwear',
    },
    {
      'name': 'Skin Care',
      'description': 'Premium skin care products.',
      'image': 'assets/images/skincare_store.jpg',
      'rating': 4.0,
      'category': 'skin-care',
    },
    {
      'name': 'Kids Toys',
      'description': 'Fun and educational toys.',
      'image': 'assets/images/kidstoys_store.webp',
      'rating': 4.4,
      'category': 'toys',
    },
    {
      'name': 'Electronics',
      'description': 'Latest gadgets and devices.',
      'image': 'assets/images/electronics_store.jpg',
      'rating': 4.2,
      'category': 'electronics',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Other Stores')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(category, context);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => CategoryItemsScreen(catLabel: category['name']),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Background Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(category['image']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    category['description'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        category['rating'].toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => CategoryItemsScreen(
                                catLabel: category['name'],
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 30),
                    ),
                    child: const Text(
                      'Visit Store',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
