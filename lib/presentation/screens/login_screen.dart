// ----------------- presentation/views/login_screen.dart -----------------
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/screens/main_screen.dart';
import 'package:deels_here/presentation/screens/sign_up_screen.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  bool obsecureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: constraints.maxHeight * 0.2),

                    const Text(
                      'Log in to your account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),

                    MyField(
                      controller: emailController,
                      label: 'Email',
                      onChanged: (value) {},
                    ),
                    MyField(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        icon: Icon(
                          obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      controller: passwordController,
                      label: 'Password',
                      obscureText: obsecureText,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<LoginController>(
                        builder:
                            (controller) => MyButton(
                              onPressed: () {
                                // check if email or password is empty
                                if (emailController.text == '' ||
                                    passwordController.text == '') {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      title: "Login Error",
                                      message:
                                          "Email and password cannot be empty",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }
                                controller.signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                              },
                              child: Text(
                                controller.isLoading
                                    ? 'Signing in...'
                                    : 'Sign in',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text('Don`t have an account ? Sign up'),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
