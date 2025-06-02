import 'package:app/domain/entities/user.dart';
import 'package:app/domain/usecases/register_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends StateNotifier<AsyncValue<User?>> {
  final RegisterUseCase _useCase;
  RegisterViewModel(this._useCase) : super(const AsyncData(null));

  Future<void> register(String name, String email, String password, String confirm) async {
    state = const AsyncLoading();
    try {
      final user = await _useCase.execute(name, email, password, confirm);
      state = AsyncData(user);
    } catch(error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}