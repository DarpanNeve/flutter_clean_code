import 'dart:ffi';

import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String authHintText;
  final TextEditingController controller;
  final bool isPassword;

  const AuthField(
      {super.key,
      required this.authHintText,
      this.isPassword = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: authHintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
