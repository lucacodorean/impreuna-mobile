import 'package:app/core/di.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_state.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier();

  /// Când vreau să forțez re‐evaluarea redirect‐urilor lui GoRouter,
  /// apelez această metodă, care intern apelează notifyListeners().
  void refresh() {
    notifyListeners();
  }
}

final goRouterRefreshNotifierProvider =
ChangeNotifierProvider<GoRouterRefreshNotifier>((ref) {
  final goRouterNotifier = GoRouterRefreshNotifier();

  ref.listen<LoginState>(loginStateProvider, (previous, next) {
    goRouterNotifier.refresh();
  });

  return goRouterNotifier;
});