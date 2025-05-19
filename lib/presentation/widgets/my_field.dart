// ----------------- core/widgets/my_field.dart -----------------
import 'package:deels_here/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String) onChanged;

  const MyField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppColors.fieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
