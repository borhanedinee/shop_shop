// ----------------- presentation/views/home_screen.dart -----------------
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';

class UploadFileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Upload product image button
                    Text(
                      'Upload Product Image',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Product Name field
                    const MyField(label: 'Product Name'),
                    // Description field
                    TextField(
                      onChanged: (value) {},
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: AppColors.fieldBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    // Add price field
                    const MyField(label: 'Add price'),
                    // Category field
                    const MyField(label: 'Category'),
                    // Schedule a post field
                    const MyField(label: 'Schedule a post'),
                    SizedBox(height: 90),
                    // Post button
                    MyButton(
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add logic to post the product
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
