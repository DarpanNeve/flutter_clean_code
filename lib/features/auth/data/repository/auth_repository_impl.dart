import 'package:flutter_clean_code/core/error/exception.dart';
import 'package:flutter_clean_code/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_data_sources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final result = await authRemoteDataSource.signUpWithEmailAndPassword(
          email: email, password: password, name: name);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
