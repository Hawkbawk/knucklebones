import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knucklebones/providers/auth_provider.dart';
import 'package:knucklebones/screens/auth/login_page.dart';
import 'package:knucklebones/screens/auth/profile_page.dart';
import 'package:knucklebones/screens/auth/signup_page.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authProvider);

    if (user != null) {
      return const ProfilePage();
    }

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            bottom: const TabBar(
                tabs: [Tab(child: Text("Login")), Tab(child: Text("Signup"))]),
          ),
          body: const Center(
              child: TabBarView(children: [LoginPage(), SignupPage()])),
        ));
  }
}
