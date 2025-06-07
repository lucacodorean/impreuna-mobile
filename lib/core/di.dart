import 'package:app/core/util/login_state.dart';
import 'package:app/data/datasources/request_data_source.dart';
import 'package:app/data/repositories/implementations/request_repository_impl.dart';
import 'package:app/data/repositories/request_repository.dart';
import 'package:app/domain/entities/request.dart';
import 'package:app/domain/entities/user.dart';
import 'package:app/domain/usecases/login_use_case.dart';
import 'package:app/domain/usecases/register_use_case.dart';
import 'package:app/domain/usecases/request_all_use_case.dart';
import 'package:app/presentation/features/auth/login/login_viewmodel.dart';
import 'package:app/presentation/features/auth/register/register_view_model.dart';
import 'package:app/presentation/features/requests/request_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app/data/datasources/auth_remote_data_source.dart';
import 'package:app/data/repositories/implementations/auth_repository_impl.dart';
import 'package:app/data/repositories/auth_repository.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:80/api/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
  ));
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    error: true,
  ));
  return dio;
});

final secureStorageProvider = Provider<FlutterSecureStorage>((_) => const FlutterSecureStorage());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSource(dio: dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDataSourceProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthRepositoryImpl(remote: remote, storage: storage);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final loginViewModelProvider =
StateNotifierProvider<LoginViewModel, AsyncValue<User?>>((ref) {
  return LoginViewModel(ref.watch(loginUseCaseProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final registerViewModelProvider =
StateNotifierProvider<RegisterViewModel, AsyncValue<User?>>((ref) {
  return RegisterViewModel(ref.watch(registerUseCaseProvider));
});

final loginStateProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

final requestRemoteDataSourceProvider = Provider<RequestDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return RequestDataSource(dio: dio);
});

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  final remote = ref.read(requestRemoteDataSourceProvider);
  return RequestRepositoryImpl(remote: remote);
});

final requestAllUseCaseProvider = Provider((ref) => RequestAllUseCase(ref.read(requestRepositoryProvider)));

final requestViewModelProvider = StateNotifierProvider<RequestViewModel, AsyncValue<List<Request>?>>(
      (ref) => RequestViewModel(ref.read(requestAllUseCaseProvider)),
);
