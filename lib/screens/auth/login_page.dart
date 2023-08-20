import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "email",
                onChanged: (value) => setState(() {
                      email = value ?? "";
                    }),
                decoration: const InputDecoration(labelText: "Email"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required()
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: "password",
              decoration: const InputDecoration(labelText: "Password"),
              onChanged: (value) => setState(() {
                password = value ?? "";
              }),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
              ]),
              obscureText: true,
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                } on FirebaseAuthException catch (e) {
                  String message;
                  switch (e.code) {
/*
invalid-email:
Thrown if the email address is not valid.
user-disabled:
Thrown if the user corresponding to the given email has been disabled.
user-not-found:
Thrown if there is no user corresponding to the given email.
wrong-password:
Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
*/
                    case "invalid-email":
                      message = "Please provide a valid email address.";
                    case "user-disabled":
                      message =
                          "That account has been disabled. Please contact support for more information.";
                    case "user-not-found":
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(actions: [
                          ElevatedButton(
                              onPressed: () => context.pop(),
                              child: const Text("No")),
                          ElevatedButton(
                              onPressed: () => context.goNamed("signup"),
                              child: const Text("Yes"))
                        ]),
                      );
                      return;
                    case "wrong-password":
                      message =
                          "Invalid password. Please double-check your password and try again.";
                    default:
                      if (kDebugMode) {
                        print("Error signing user in: ${e.message}");
                      }
                      message =
                          "Sorry, but something went wrong on our end. Please try again.";
                  }

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                  return;
                }

                // ignore: use_build_context_synchronously
                context.goNamed("profile");
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              label: const Text("Login"))
        ],
      ),
    );
  }
}
