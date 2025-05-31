// presentation/controllers/home_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deels_here/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<ProductModel> productsToDisplay = <ProductModel>[];

  List<ProductModel> allProducts = <ProductModel>[];
  List<ProductModel> filteredroducts = <ProductModel>[];

  @override
  void onInit() {
    super.onInit();
    // Simulate loading products (replace with your data source, e.g., API or Firestore)
    fetchProducts();
  }

  bool isFetchingProducts = false;
  void fetchProducts() async {
    try {
      isFetchingProducts = true;
      update(); // Notify listeners that fetching has started
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      allProducts =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return ProductModel.fromJson(data);
          }).toList();
      productsToDisplay = allProducts; // Initially display all products
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Failed to fetch products: $e',
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ),
      );
    } finally {
      isFetchingProducts = false;
      update();
    }
  }

  String selectedCategory = 'All';
  fetchProductsByCategory(String category) async {
    try {
      isFetchingProducts = true;
      update(); // Notify listeners that fetching has started

      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      // filter products by category
      filteredroducts =
          allProducts.where((product) {
            return product.category.toLowerCase() == category.toLowerCase();
          }).toList();
      productsToDisplay = filteredroducts;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching products by category: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Failed to fetch products by category: $e',
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ),
      );
    } finally {
      isFetchingProducts = false;
      update();
    }
  }

  // filter products by seller name
  bool isFetchingSellerProducts = false;
  List<ProductModel> sellerProducts = <ProductModel>[];

  filterProductsBySellerName(String sellerName) async {
    isFetchingSellerProducts = true;
    update();
    await Future.delayed(Duration(seconds: 2));
    sellerProducts =
        allProducts
            .where(
              (product) =>
                  product.sellerName.toLowerCase() == sellerName.toLowerCase(),
            )
            .toList();

    isFetchingSellerProducts = false;
    update();
  }

  // filter searched products
  filterSearchedProducts(String value) async {
    selectedCategory = 'All'; // Reset category filter
    update();
    if (value.isEmpty) {
      productsToDisplay = allProducts;
    } else {
      // filter products based on search value

      isFetchingProducts = true;
      update(); // Notify listeners that fetching has started
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      productsToDisplay =
          allProducts.where((product) {
            return product.name.toLowerCase().contains(value.toLowerCase()) ||
                product.description.toLowerCase().contains(value.toLowerCase());
          }).toList();
      isFetchingProducts = false;
      update();
    }
  }

  final List<Map<String, dynamic>> productsToUpload = [
    {
      "name": "Classic Teddy Bear",
      "description": "A soft and cuddly teddy bear perfect for kids' playtime.",
      "price": 2500,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720979/teddy-bear_xk20kh.jpg",
      "category": "Kids Toys",
      "stock": 50,
      "isAvailable": true,
      "sellerName": "ToyWorld",
      "colors": ["Brown"],
    },
    {
      "name": "Ordinary for Acne",
      "description":
          "A lightweight acne treatment serum for clear and healthy skin.",
      "price": 4500,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720979/ordinary-for-acne_wms8n7.webp",
      "category": "Skin Care",
      "stock": 30,
      "isAvailable": true,
      "sellerName": "SkinGlow",
    },
    {
      "name": "Ordinary Alpha",
      "description":
          "An effective alpha hydroxy acid solution for skin exfoliation.",
      "price": 3800,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720979/ordinary-alpha_e4mvml.webp",
      "category": "Skin Care",
      "stock": 40,
      "isAvailable": true,
      "sellerName": "SkinGlow",
    },
    {
      "name": "Rubik's Cube",
      "description": "A classic brain-teasing puzzle toy for kids and adults.",
      "price": 1200,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720979/rubiks-cube_qq31cp.webp",
      "category": "Kids Toys",
      "stock": 75,
      "isAvailable": true,
      "sellerName": "ToyWorld",
      "colors": ["Multicolor"],
    },
    {
      "name": "AirPod Pro",
      "description": "High-quality wireless earbuds with noise cancellation.",
      "price": 18000,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720978/airpod_pro_wudffi.jpg",
      "category": "Electronics",
      "stock": 20,
      "isAvailable": true,
      "sellerName": "TechTrend",
      "colors": ["White"],
    },
    {
      "name": "Blue Teddy Bear",
      "description":
          "A plush blue teddy bear for a fun and colorful play experience.",
      "price": 2800,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720978/blue-teddy-bear_ktss3x.webp",
      "category": "Kids Toys",
      "stock": 60,
      "isAvailable": true,
      "sellerName": "ToyWorld",
      "colors": ["Blue"],
    },
    {
      "name": "AirPods Max Noir",
      "description": "Premium over-ear headphones with superior sound quality.",
      "price": 45000,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720978/airpods-max-noir-1_q0rn08.jpg",
      "category": "Electronics",
      "stock": 15,
      "isAvailable": true,
      "sellerName": "TechTrend",
      "colors": ["Black"],
    },
    {
      "name": "Apple Watch",
      "description": "Smartwatch with fitness tracking and notifications.",
      "price": 30000,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720978/apple-watch_oul1ug.png",
      "category": "Electronics",
      "stock": 25,
      "isAvailable": true,
      "sellerName": "TechTrend",
      "colors": ["Silver", "Black"],
    },
    {
      "name": "Ordinary Dry Skin",
      "description": "A moisturizing cream for dry skin relief and hydration.",
      "price": 3200,
      "avatar":
          "https://res.cloudinary.com/dg6yzepco/image/upload/v1748720978/ordinary-dry-skin_ljey8f.jpg",
      "category": "Skin Care",
      "stock": 35,
      "isAvailable": true,
      "sellerName": "SkinGlow",
    },
  ];

  uploadProducts() async {
    // via firebase
    for (final product in productsToUpload) {
      await FirebaseFirestore.instance.collection('products').add(product);
    }
  }
}
