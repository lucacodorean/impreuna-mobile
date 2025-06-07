import 'package:app/core/di.dart';
import 'package:app/presentation/features/requests/requests_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {

    final loginState = ref.watch(loginViewModelProvider);


    const List<Widget> pages = <Widget>[
      RequestsPage(),
      Center(child: Text('Events Screen')),
      Center(child: Text('Profile Screen')),
    ];

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

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
            title: const Text('iMpreună'),
          ),
          body: IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemTapped,
              destinations: const<NavigationDestination> [
                NavigationDestination(icon: Icon(Icons.request_quote), label: "Cereri"),
                NavigationDestination(icon: Icon(Icons.event), label: "Evenimente"),
                NavigationDestination(icon: Icon(Icons.verified_user), label: "Profil")
              ],

          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('A apărut o eroare: $e')),
    );
  }
}