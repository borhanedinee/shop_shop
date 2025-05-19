// ----------------- presentation/views/login_screen.dart -----------------
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/screens/main_screen.dart';
import 'package:deels_here/presentation/screens/sign_up_screen.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in to your account',
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
                    MyField(label: 'Email', onChanged: (value) {}),
                    MyField(
                      label: 'Password',
                      obscureText: true,
                      onChanged: (value) {},
                    ),
                    MyField(
                      label: 'Confirm Password',
                      obscureText: true,
                      onChanged:
                          (
                            value,
                          ) {}, // Not used in login logic but included as per design
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        onPressed: () {
                          Get.to(MainScreen());
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: const Text('Don`t have an account ? Sign up'),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
