import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoggedIn;
  LoginState({required this.isLoggedIn});
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState(isLoggedIn: false));

  void logIn() => state = LoginState(isLoggedIn: true);
  void logOut() => state = LoginState(isLoggedIn: false);
}
