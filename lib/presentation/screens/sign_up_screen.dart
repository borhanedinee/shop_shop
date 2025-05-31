// ----------------- presentation/views/login_screen.dart -----------------
import 'dart:convert';

import 'package:deels_here/domain/models/user_model.dart';
import 'package:deels_here/main.dart';
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/controller/signup_controller.dart';
import 'package:deels_here/presentation/screens/login_screen.dart';
import 'package:deels_here/presentation/screens/main_screen.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:deels_here/services/user_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool obsecureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create new account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              margin: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyField(
                      controller: firstNameController,
                      label: 'First name',
                      onChanged: (value) {},
                    ),
                    MyField(
                      controller: lastNameController,
                      label: 'Last name',
                      onChanged: (value) {},
                    ),

                    MyField(
                      controller: emailController,
                      label: 'Email',
                      onChanged: (value) {},
                    ),
                    MyField(
                      controller: phoneController,
                      label: 'Phone',
                      onChanged: (value) {},
                    ),
                    MyField(
                      controller: passwordController,
                      label: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                      ),

                      obscureText: !obsecureText,

                      onChanged: (value) {},
                    ),
                    MyField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                      ),

                      obscureText: !obsecureText,

                      onChanged:
                          (
                            value,
                          ) {}, // Not used in login logic but included as per design
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<SignupController>(
                        builder:
                            (controller) => MyButton(
                              onPressed: () {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      title: 'Error',
                                      message: 'Passwords do not match',
                                      duration: Duration(seconds: 3),
                                      snackPosition: SnackPosition.BOTTOM,
                                    ),
                                  );
                                  return;
                                }
                                // create user
                                if (firstNameController.text.isEmpty ||
                                    lastNameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    phoneController.text.isEmpty ||
                                    passwordController.text.isEmpty) {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      title: 'Error',
                                      message: 'Please fill all fields',
                                      duration: Duration(seconds: 3),
                                      snackPosition: SnackPosition.BOTTOM,
                                    ),
                                  );
                                  return;
                                }
                                String uid =
                                    DateTime.now().millisecondsSinceEpoch
                                        .toString();

                                // create user model
                                final user = UserModel(
                                  id: uid,
                                  firstName: firstNameController.text,
                                  secondName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                                Get.find<SignupController>()
                                    .signUpUser(user)
                                    .then((error) {
                                      if (error == null) {
                                        // save user to shared preferences
                                        saveUserToSharedPreferences(user);
                                        // save user
                                        currentUser = user;
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            title: 'Success',
                                            message:
                                                'Account created successfully',
                                            duration: Duration(seconds: 3),
                                            snackPosition: SnackPosition.BOTTOM,
                                          ),
                                        );
                                        isGuest = false;

                                        // Navigate to login screen
                                        Navigator.of(
                                          context,
                                        ).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Error',
                                          error,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    });
                              },
                              child: Text(
                                controller.isLoading
                                    ? 'Signing up...'
                                    : 'Sign up',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Already have an account ? log in'),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
