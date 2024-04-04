import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});

  Future<Either<Failure, String>> signInWithGoogle();

  Future<Either<Failure, String>> signInWithFacebook();

  Future<Either<Failure, String>> signInWithApple();

  Future<Either<Failure, String>> signOut();

  Future<Either<Failure, String>> getCurrentUser();
}
