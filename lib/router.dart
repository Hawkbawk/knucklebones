import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knucklebones/screens/auth/login_page.dart';
import 'package:knucklebones/screens/auth/signup_page.dart';
import 'package:knucklebones/screens/home_page.dart';

final router = GoRouter(routes: [
  GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
          ),
          body: const HomePage()),
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
        )
      ]),
], initialLocation: "/");
