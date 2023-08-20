import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:knucklebones/providers/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  var newUsername = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            // The profile page is only rendered if the user is already
            // signed in.
            await ref.read(authProvider)!.updateDisplayName(newUsername);
          },
          child: const Icon(Icons.cloud_upload)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FormBuilderTextField(
                decoration: const InputDecoration(labelText: "Username"),
                name: 'username',
                onChanged: (value) => setState(() {
                  newUsername = value ?? "";
                }),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.min(3)
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
