import 'package:flutter_clean_code/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
// Compare this snippet from lib/features/auth/data/dataSources/auth_remote_data_sources.dart:

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw ServerException(message: "User is null");
    }
    return response.user!.id;
  }

  @override
  Future<String> signUpWithEmailAndPassword(
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
      return response.user!.id;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
