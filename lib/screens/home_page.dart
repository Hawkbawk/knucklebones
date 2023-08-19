import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(children: [
        ElevatedButton.icon(
            onPressed: () => context.pushNamed("login"),
            icon: const Icon(Icons.arrow_circle_right_outlined),
            label: const Text("Login")),
        ElevatedButton.icon(
            onPressed: () => context.pushNamed("signup"),
            icon: const Icon(Icons.arrow_circle_right_outlined),
            label: const Text("Signup"))
      ]),
    );
  }
}
