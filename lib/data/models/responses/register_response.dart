import 'package:app/data/models/dtos/user_model.dart';

class RegisterResponse {
  final String token;
  final UserModel user;
  RegisterResponse({
    required this.token,
    required this.user
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        token: json["token"] as String,
        user:  UserModel.fromJson(json["data"] as Map<String, dynamic> )
    );
  }
}