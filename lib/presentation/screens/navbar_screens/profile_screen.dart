// ----------------- presentation/views/profile_screen.dart -----------------
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Name: John Doe'),
            const SizedBox(height: 10),
            const Text('Email: john.doe@example.com'),
            const SizedBox(height: 20),
            MyButton(onPressed: () => {}, child: const Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
