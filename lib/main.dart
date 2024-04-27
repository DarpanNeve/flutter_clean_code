import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_clean_code/core/routes.dart';
import 'package:flutter_clean_code/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_code/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_clean_code/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_clean_code/init_dependencies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/theme.dart';
import 'features/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(UserLoggedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      darkTheme: AppTheme.darkThemeMode,
      theme: AppTheme.lightThemeMode,
      themeMode: ThemeMode.system,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) => state is AppUserLoggedIn,
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
