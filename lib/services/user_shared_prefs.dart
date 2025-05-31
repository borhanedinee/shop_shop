import 'dart:convert';

import 'package:deels_here/domain/models/user_model.dart';
import 'package:deels_here/main.dart';

void saveUserToSharedPreferences(UserModel user) {
  print('Saving user to shared preferences');
  // save user to shared prefs
  // save each property separately
  final userJson = {
    'id': user.id,
    'firstName': user.firstName,
    'secondName': user.secondName,
    'email': user.email,
    'phone': user.phone,
    'password': user.password,
  };
  sharedPreferences!.setString('user', jsonEncode(userJson));

  print('User saved: ${user.toJson()}');
}

void getSavedUser() {
  print('Getting saved user');
  // get user from shared prefs
  String? userJson = sharedPreferences!.getString('user');
  // string to json
  final json = jsonDecode(userJson!);
  currentUser = UserModel.fromJson(json);
  print('Current user: ${currentUser!.toJson()}');
}
