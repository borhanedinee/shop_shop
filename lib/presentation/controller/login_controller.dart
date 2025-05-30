import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deels_here/domain/models/user_model.dart';
import 'package:deels_here/main.dart';
import 'package:deels_here/presentation/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  Future<void> signIn(String email, String password) async {
    try {
      isLoading = true;
      update(); // Notify listeners that loading has started

      // 2. Get user document from Firestore
      final snapshot =
          await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .where('password', isEqualTo: password)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        currentUser = UserModel.fromJson(snapshot.docs.first.data());
        // snack bar for suucess
        Get.showSnackbar(
          GetSnackBar(
            title: "Login Success",
            message: "Welcome back, ${currentUser!.firstName.capitalize}!",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          ),
        );
        // Navigate to main screen
        Get.offAll(MainScreen()); // Assuming you have a route named '/main'
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: "Login Error",
            message: "Invalid email or password",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          ),
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Login Error",
          message: e.message ?? "An error occurred during login",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Login Error",
          message: "An unexpected error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      isLoading = false;
      update(); // Notify listeners that loading has completed
    }
  }
}
