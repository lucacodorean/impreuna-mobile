import 'package:app/data/models/responses/login_response.dart';
import 'package:app/data/models/responses/register_response.dart';
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
        },
        options: Options(headers: {
          'Connection': 'close',
          'Accept': 'application/json',
        }),
      );

      return LoginResponse.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
    required String confirmed}) async {
    final resp = await dio.post(
      "auth/register",
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmed
      },
      options: Options(headers: {
        'Connection': 'close',
        'Accept': 'application/json',
      }),
    );

    return RegisterResponse.fromJson(resp.data as Map<String, dynamic>);
  }
}