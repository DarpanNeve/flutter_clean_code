import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code/core/routes.dart';
import 'package:flutter_clean_code/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc/auth_bloc.dart';
import 'core/theme/theme.dart';
import 'features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'features/auth/domain/usercases/user_sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              authRemoteDataSource: AuthRemoteDataSourceImpl(
                supabaseClient: supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
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
    );
  }
}
