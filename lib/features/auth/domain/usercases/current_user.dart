import 'package:flutter_clean_code/core/error/failure.dart';
import 'package:flutter_clean_code/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.currentUser();
  }
}
