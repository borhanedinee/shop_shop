// ----------------- core/widgets/my_field.dart -----------------
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const MyField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppColors.fieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
