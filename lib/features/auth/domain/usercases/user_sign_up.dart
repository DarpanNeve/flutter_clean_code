import 'package:flutter_clean_code/core/error/failure.dart';
import 'package:flutter_clean_code/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/auth_repository.dart';

class SignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
