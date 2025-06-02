import 'package:app/presentation/features/auth/login/login_view.dart';
import 'package:app/presentation/features/auth/register/register_view.dart';
import 'package:app/presentation/features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginView()),
    GoRoute(path: '/home',  builder: (_, __) => const HomeView()),
    GoRoute(path: '/register', builder: (_,__) => const RegisterView())
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'iMpreuna',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
