import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
