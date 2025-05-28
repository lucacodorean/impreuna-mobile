import 'package:app/core/di.dart';
import 'package:app/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailControl = TextEditingController();
  final _passControl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    ref.listen<AsyncValue<User?>>(loginViewModelProvider, (_,value) {
      value.when(
          data: (user) {
            if(user != null) context.go("/home");
          },
          error: (e,_) => ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(content: Text("Error: $e"))),
          loading: () {}
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text("iMpreuna")),
    );
  }
}
