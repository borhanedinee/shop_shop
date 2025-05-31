import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deels_here/domain/models/user_model.dart';
import 'package:deels_here/firebase_options.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/controller/home_controller.dart';
import 'package:deels_here/presentation/controller/login_controller.dart';
import 'package:deels_here/presentation/controller/signup_controller.dart';
import 'package:deels_here/presentation/screens/login_screen.dart';
import 'package:deels_here/presentation/screens/main_screen.dart';
import 'package:deels_here/presentation/screens/splash_screen.dart';
import 'package:deels_here/services/user_shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

UserModel? currentUser;

// Shared preferences for storing user data
SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // check if there is a saved user
    String? userJson = sharedPreferences!.getString('user');
    bool isUserSaved;
    if (userJson != null) {
      getSavedUser();
      isUserSaved = true;
    } else {
      isUserSaved = false;
      print('No user found in shared preferences');
    }
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        // Initialize any controllers or services here
        Get.put(CartController());
        Get.put(LoginController());
        Get.put(SignupController());
        Get.put(HomeController());
        // Get.find<HomeController>().uploadProducts();
      }),
      home: isUserSaved ? MainScreen() : SplashScreen(),
    );
  }
}
