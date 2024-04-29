import 'package:flutter_clean_code/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_code/features/auth/domain/usercases/current_user.dart';
import 'package:flutter_clean_code/features/auth/domain/usercases/user_login.dart';
import 'package:flutter_clean_code/features/auth/domain/usercases/user_sign_up.dart';
import 'package:flutter_clean_code/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/blog/data/data_sources/blog_remote_data_source.dart';
import 'features/blog/data/repository/blog_repositroy_impl.dart';
import 'features/blog/domain/repository/blog_repository.dart';
import 'features/blog/domain/use_cases/get_all_blogs.dart';
import 'features/blog/domain/use_cases/upload_blog.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator<SupabaseClient>(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
      ),
    )
    //UseCase
    ..registerFactory(
      () => UserSignUp(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        appUserCubit: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
      ),
    );
}

_initBlog() {
  //DataSource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator<SupabaseClient>(),
      ),
    )
    //Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
      ),
    )
    //UseCase
    ..registerFactory(
      () => UploadBlog(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        blogRepository: serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
