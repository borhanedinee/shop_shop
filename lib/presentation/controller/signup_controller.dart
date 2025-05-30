import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deels_here/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  Future<String?> signUpUser(UserModel userModel) async {
    try {
      isLoading = true;
      update(); // Notify listeners that loading has started

      // 2. Create Firestore user document
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());

      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    } catch (e) {
      return 'Something went wrong. Please try again later.'; // General error
    } finally {
      isLoading = false;
      update(); // Notify listeners that loading has completed
    }
  }
}
