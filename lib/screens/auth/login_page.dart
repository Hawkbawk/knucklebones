import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

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
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required()
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "password",
                decoration: const InputDecoration(labelText: "Password"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(8),
                ]),
                obscureText: true,
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: const Text("Login"))
          ],
        ));
  }
}
