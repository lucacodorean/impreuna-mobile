import 'package:app/data/datasources/auth_remote_data_source.dart';
import 'package:app/data/models/responses/login_response.dart';
import 'package:app/data/models/responses/register_response.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/domain/entities/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remote;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl({
    required this.remote,
    required this.storage
  });

  @override
  Future<User> login(String email, String password) async {
    final LoginResponse response = await remote.login(email: email, password: password);

    await storage.write(key: "JWT", value: response.token);
    return response.user.toEntity();
  }

  @override
  Future<User> register(String name, String email, String password, String confirmed) async {
    final RegisterResponse response = await remote.register(
      name: name,
      email: email,
      password: password,
      confirmed: confirmed
    );

    await storage.write(key: "JWT", value: response.token);
    return response.user.toEntity();
  }
}