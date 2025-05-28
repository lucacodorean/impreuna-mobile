import 'package:app/presentation/features/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginView()),
    GoRoute(path: '/home',  builder: (_, __) => const MyApp()),
  ],
);


/// MyApp is the root widget of the iMpreuna application.
/// This placeholder demonstrates basic setup with MaterialApp.
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iMpreuna Home'),
      ),
      body: const Center(
        child: Text(
          apiBaseUrl,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
