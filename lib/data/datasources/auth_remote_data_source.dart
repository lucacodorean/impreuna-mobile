import 'package:app/core/di.dart';
import 'package:app/data/models/responses/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio: dio);
});