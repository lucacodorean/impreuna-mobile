import 'package:app/domain/entities/user.dart';
import 'package:app/domain/usecases/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<AsyncValue<User?>> {
  final LoginUseCase _useCase;
  LoginViewModel(this._useCase) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _useCase.execute(email, password);
      state = AsyncData(user);
    } catch(error, stackTrace) {
        state = AsyncError(error, stackTrace);
    }
  }
}