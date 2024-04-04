import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignUpPage(),
};
