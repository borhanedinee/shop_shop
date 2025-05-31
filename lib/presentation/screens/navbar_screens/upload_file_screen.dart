// presentation/views/home_screen.dart
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/screens/login_screen.dart';
import 'package:deels_here/presentation/widgets/gues_login_widget.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';

class UploadFileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isGuest
              ? GuestLoginWidget()
              : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Header
                      Text(
                        'Upload Product',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add a new product to your store',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),
                      // Form Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Upload Product Image
                              Text(
                                'Upload Product Image',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              MyButton(
                                onPressed: () async {
                                  // final result = await FilePicker.platform.pickFiles(
                                  //   type: FileType.image,
                                  // );
                                  // if (result != null) {
                                  //   // Handle the selected file (e.g., upload to Firebase)
                                  //   final file = File(result.files.single.path!);
                                  //   // Add your upload logic here
                                  // }
                                },
                                child: const Text(
                                  'Select Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Product Name field
                              const MyField(label: 'Product Name'),
                              const SizedBox(height: 16),
                              // Description field
                              TextField(
                                onChanged: (value) {},
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  filled: true,
                                  fillColor: AppColors.fieldBackground,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Price field
                              const MyField(label: 'Price'),
                              const SizedBox(height: 16),
                              // Category field
                              const MyField(label: 'Category'),
                              const SizedBox(height: 16),
                              // Schedule a post field
                              const MyField(label: 'Schedule a Post'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Post Button with Animation
                      Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1.0,
                          child: MyButton(
                            onPressed: () {
                              // Add logic to post the product
                              Get.snackbar(
                                'Success',
                                'Product uploaded!',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppColors.primaryColor,
                                colorText: Colors.white,
                              );
                            },
                            child: const Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
    );
  }
}
