import 'package:flutter/material.dart';
import 'package:flutter_clean_code/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_clean_code/features/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            const AuthField(authHintText: "Email"),
            SizedBox(height: size.height * 0.025),
            const AuthField(authHintText: "Email"),
            SizedBox(height: size.height * 0.025),
            const AuthField(authHintText: "Email"),
            SizedBox(height: size.height * 0.03),
            const AuthGradientButton(),
          ],
        ),
      ),
    );
  }
}
