import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String authHintText;

  const AuthField({super.key, required this.authHintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: authHintText,
      ),
    );
  }
}
