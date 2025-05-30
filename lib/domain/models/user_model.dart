class UserModel {
  final String id;
  final String firstName;
  final String secondName;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.id,

    required this.firstName,
    required this.secondName,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],

      firstName: json['firstName'],
      secondName: json['secondName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
