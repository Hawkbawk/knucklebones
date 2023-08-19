import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  User? build() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = user;
    });
    return FirebaseAuth.instance.currentUser;
  }
}
