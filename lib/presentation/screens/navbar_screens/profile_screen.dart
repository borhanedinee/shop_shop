// presentation/screens/navbar_screens/profile_screen.dart
import 'package:deels_here/main.dart';
import 'package:deels_here/presentation/controller/home_controller.dart';
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/screens/login_screen.dart';
import 'package:deels_here/presentation/widgets/gues_login_widget.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              height: constraints.maxHeight,
              child:
                  isGuest
                      ? GuestLoginWidget()
                      : SingleChildScrollView(
                        child: Stack(
                          children: [
                            // Background image
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/backg.jpg',
                                  ), // Add your background image in assets
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Back arrow
                            // Positioned(
                            //   top: 40,
                            //   left: 16,
                            //   child: IconButton(
                            //     icon: const Icon(Icons.arrow_back, color: Colors.white),
                            //     onPressed: () {
                            //       Navigator.pop(context);
                            //     },
                            //   ),
                            // ),
                            // Profile content
                            Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Column(
                                children: [
                                  // Profile avatar
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.webp',
                                    ), // Add your profile image in assets
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(height: 16),
                                  // Name
                                  Text(
                                    '${currentUser!.firstName.capitalize} ${currentUser?.secondName.capitalize}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Role
                                  const Text(
                                    'Buyer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Profile fields
                                  _buildProfileField(context, 'Name'),
                                  _buildProfileField(context, 'Phone number'),
                                  _buildProfileField(context, 'Email'),
                                  _buildProfileField(context, 'Role'),
                                  _buildProfileField(context, 'Password'),
                                  _buildProfileField(context, 'Settings'),
                                  SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: MyButton(
                                      onPressed: () async {
                                        // logout , and clear shared prefs
                                        await Get.find<LoginController>()
                                            .logout();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                          (route) => false,
                                        );
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            message: 'Logged out successfully',
                                          ),
                                        );
                                      },
                                      child: GetBuilder<LoginController>(
                                        builder:
                                            (controller) => Text(
                                              controller.isLoggingOut
                                                  ? 'Logging out ...'
                                                  : 'Logout',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 100),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
