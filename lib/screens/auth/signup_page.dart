import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulHookWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  var email = "";
  var password = "";
  var confirmedPassword = "";

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
              decoration: const InputDecoration(labelText: "Email"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email()
              ]),
              onChanged: (value) => setState(() {
                email = value ?? "";
              }),
            ),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: "confirm_password",
              decoration: const InputDecoration(labelText: "Confirm Password"),
              onChanged: (val) => setState(() {
                confirmedPassword = val ?? "";
              }),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                (value) {
                  if (value != password) {
                    return "Please ensure your passwords match.";
                  }
                  return null;
                }
              ]),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                } on FirebaseAuthException catch (e) {
                  String message;
                  switch (e.code) {
                    case "email-already-in-use":
                      message =
                          "That email is already being used. Please check to see if you already have an account with us.";
                    case "invalid-email":
                      message =
                          "That email was invalid. Please enter a valid email";
                    case "operation-not-allowed":
                      message = "Sorry, something went wrong on our end.";
                    case "weak-password":
                      message = "Please choose a stronger password.";
                    default:
                      // TODO: Replace this with a message to firebase crashalytics,
                      // once that's part of the app.
                      if (kDebugMode) {
                        print(
                            "Something went very wrong. Here's the Firebase error message:\n${e.message}");
                      }
                      message =
                          "Sorry, something went wrong. Please try again.";
                  }
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                  return;
                }

                // ignore: use_build_context_synchronously
                context.goNamed("profile");
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              label: const Text("Signup"))
        ],
      ),
    );
  }
}
