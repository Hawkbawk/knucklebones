import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knucklebones/nested_scaffold.dart';
import 'package:knucklebones/screens/auth/auth_page.dart';
import 'package:knucklebones/screens/auth/login_page.dart';
import 'package:knucklebones/screens/auth/profile_page.dart';
import 'package:knucklebones/screens/auth/signup_page.dart';
import 'package:knucklebones/screens/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NestedScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            name: "home",
            path: "/",
            builder: (context, state) => const HomePage(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: "/auth",
              builder: (context, state) => const AuthPage(),
              routes: [
                GoRoute(
                  name: "login",
                  path: "login",
                  builder: (context, state) => Scaffold(
                      appBar: AppBar(
                        title: const Text("Login"),
                      ),
                      body: const LoginPage()),
                ),
                GoRoute(
                  name: "signup",
                  path: "signup",
                  builder: (context, state) => Scaffold(
                      appBar: AppBar(
                        title: const Text("Signup"),
                      ),
                      body: const SignupPage()),
                ),
                GoRoute(
                  name: "profile",
                  path: "profile",
                  builder: (context, state) => const ProfilePage(),
                )
              ]),
        ])
      ])
]);
