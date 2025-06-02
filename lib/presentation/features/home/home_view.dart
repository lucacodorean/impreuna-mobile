import 'package:app/core/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget  {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginState = ref.watch(loginViewModelProvider);

    return loginState.when(
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).go('/login');
          });
          return const SizedBox();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('iMpreuna Home'),
          ),
          body:Center(
              child: Text(
                "Hello, ${user.name}!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              )
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('A apărut o eroare: $e')),
    );
  }
}