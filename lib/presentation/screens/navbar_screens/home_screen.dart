// ----------------- presentation/views/home_screen.dart -----------------
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Shopping App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            MyButton(onPressed: () {}, child: const Text('View My Cart')),
          ],
        ),
      ),
    );
  }
}
