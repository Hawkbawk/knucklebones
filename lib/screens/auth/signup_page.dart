import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
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
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: const Text("Signup"))
          ],
        ));
  }
}
