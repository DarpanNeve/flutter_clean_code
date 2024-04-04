import 'package:flutter/material.dart';
import 'package:flutter_clean_code/core/routes.dart';
import 'package:flutter_clean_code/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_code/features/auth/presentation/pages/signup_page.dart';

import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      darkTheme: AppTheme.darkThemeMode,
      theme: AppTheme.lightThemeMode,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
