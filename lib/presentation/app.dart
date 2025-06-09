import 'package:app/core/di.dart';
import 'package:app/core/util/router_refresh_notified.dart';
import 'package:app/presentation/features/auth/login/login_view.dart';
import 'package:app/presentation/features/auth/register/register_view.dart';
import 'package:app/presentation/features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final goRouter = GoRouter(
      initialLocation: '/',
      refreshListenable: ref.watch(goRouterRefreshNotifierProvider),
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterView(),
        ),
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeView(),
          redirect: (BuildContext context, GoRouterState state) {
            final loggedIn = ref.read(loginStateProvider).isLoggedIn;
            if (!loggedIn) return '/login';
            return null;
          },
        ),
      ],

      /// This redirect acts as a global redirect, thus if an logged user attempts to access
      /// the login page, they will get redirected here.
      redirect: (BuildContext context, GoRouterState state) {
        final loggedIn = ref.read(loginStateProvider).isLoggedIn;
        final goingToLogin = state.matchedLocation == '/login';

        if (!loggedIn && !goingToLogin) return '/login';
        if (loggedIn && goingToLogin) return '/';
        return null;
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
