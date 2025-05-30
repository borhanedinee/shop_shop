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

  // filter searched products
  filterSearchedProducts(String value) async {
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
      "name": "Urban Tee Classic",
      "description": "Soft and breathable cotton tee for everyday streetwear.",
      "price": 3200,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556486/tshirt-4_l8qeqt.webp",
      "sizes": ["S", "M", "L", "XL"],
      "category": "Clothing",
      "stock": 100,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "Minimalist Vibe Tee",
      "description": "Clean-cut design t-shirt perfect for casual fits.",
      "price": 3000,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/tshirt-2_u4hqbf.webp",
      "sizes": ["S", "M", "L"],
      "category": "Clothing",
      "stock": 80,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "Premium Fit Tee",
      "description": "Modern fit t-shirt with durable stitching.",
      "price": 3500,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/tshirt-3_n7tdmk.jpg",
      "sizes": ["M", "L", "XL"],
      "category": "Clothing",
      "stock": 70,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "SpeedFlex Sneakers",
      "description": "Lightweight and responsive sneakers for daily runs.",
      "price": 6900,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/sneakers-3_tyzfz1.jpg",
      "sizes": ["37", "38", "39", "40", "41", "42", "43", "44"],
      "category": "Footwear",
      "stock": 60,
      "isAvailable": true,
      "sellerName": "ShopMaster",
    },
    {
      "name": "Everyday Cotton Tee",
      "description": "Essential cotton tee for layering or solo wear.",
      "price": 2900,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/tshirt_ib70ff.webp",
      "sizes": ["S", "M", "L", "XL"],
      "category": "Clothing",
      "stock": 90,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "Alpha Street Sneakers",
      "description": "Bold style sneakers with comfort-engineered soles.",
      "price": 7200,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/sneakers-4_fnvkmy.jpg",
      "sizes": ["37", "38", "39", "40", "41", "42", "43", "44"],
      "category": "Footwear",
      "stock": 55,
      "isAvailable": true,
      "sellerName": "ShopMaster",
    },
    {
      "name": "Stealth Mode Hoodie",
      "description": "Sleek black hoodie with a soft fleece interior.",
      "price": 5800,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/hoodie-black_ef97h5.webp",
      "sizes": ["S", "M", "L", "XL", "XXL"],
      "category": "Clothing",
      "stock": 75,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "Night Rider Hoodie",
      "description": "All-black minimalist hoodie with warm comfort.",
      "price": 6000,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/hoodie-black2_xv0o1k.webp",
      "sizes": ["S", "M", "L", "XL"],
      "category": "Clothing",
      "stock": 65,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "Classic Chill Hoodie",
      "description": "Relaxed-fit hoodie perfect for cool evenings.",
      "price": 5200,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/hoodie_i4wkgl.jpg",
      "sizes": ["M", "L", "XL", "XXL"],
      "category": "Clothing",
      "stock": 50,
      "isAvailable": true,
      "sellerName": "ShopMaster",
      "colors": ["Black", "White", "Blue"],
    },
    {
      "name": "TrailBlazer Sneakers",
      "description": "Rugged and ready sneakers for the urban explorer.",
      "price": 6700,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/sneakers_s6b7du.webp",
      "sizes": ["37", "38", "39", "40", "41", "42", "43", "44"],
      "category": "Footwear",
      "stock": 85,
      "isAvailable": true,
      "sellerName": "ShopMaster",
    },
    {
      "name": "Fusion X Sneakers",
      "description": "Hybrid comfort sneakers with sporty design.",
      "price": 7100,
      "avatar":
          "https://res.cloudinary.com/djfpmaasb/image/upload/v1748556485/sneakerstwo_lqwz1h.webp",
      "sizes": ["37", "38", "39", "40", "41", "42", "43", "44"],
      "category": "Footwear",
      "stock": 70,
      "isAvailable": true,
      "sellerName": "ShopMaster",
    },
  ];

  uploadProducts() async {
    print('Uploading products to Firestore...');
    // via firebase
    for (final product in productsToUpload) {
      await FirebaseFirestore.instance.collection('products').add(product);
    }
  }
}
