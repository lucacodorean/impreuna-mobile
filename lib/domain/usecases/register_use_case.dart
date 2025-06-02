import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/domain/entities/user.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);

  Future<User> execute(String name, String email, String password, String confirmed) {
    return _authRepository.register(name, email, password, confirmed);
  }
}