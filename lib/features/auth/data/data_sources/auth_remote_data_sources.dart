import 'package:flutter_clean_code/core/error/exception.dart';
import 'package:flutter_clean_code/features/auth/data/models/user_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<UserModel> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
// Compare this snippet from lib/features/auth/data/dataSources/auth_remote_data_sources.dart:

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw ServerException(message: "User is null");
    }
    return UserModel.fromJson(response.user!.toJson());
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw ServerException(message: "User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
        throw Exception(e.toString());
    }
  }
}
