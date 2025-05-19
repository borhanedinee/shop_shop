// ----------------- presentation/views/login_screen.dart -----------------
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/controller/signup_controller.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:deels_here/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

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
                    MyField(label: 'First name', onChanged: (value) {}),
                    MyField(label: 'Last name', onChanged: (value) {}),

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
                        onPressed: () {},
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
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
