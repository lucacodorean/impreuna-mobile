import 'package:app/data/models/dtos/user_model.dart';

class LoginResponse {
  final String token;
  final UserModel user;
  LoginResponse({
    required this.token,
    required this.user
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["attributes"]["token"],
      user:  UserModel.fromJson(json)
    );
  }
}