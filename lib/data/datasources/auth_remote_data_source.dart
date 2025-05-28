import 'package:app/data/models/responses/login_response.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({required this.dio});

  Future<LoginResponse> login({
  required String email,
  required String password}) async {
      final resp = await dio.post(
          "auth/login",
          data: {
            'email': email,
            'password': password
          }
      );

      return LoginResponse.fromJson(resp.data as Map<String, dynamic>);
  }
}