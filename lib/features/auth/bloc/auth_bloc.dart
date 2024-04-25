import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code/core/usecases/usecase.dart';
import 'package:flutter_clean_code/features/auth/domain/usercases/user_sign_up.dart';
import '../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../core/common/entities/user.dart';
import '../domain/usercases/current_user.dart';
import '../domain/usercases/user_login.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required CurrentUser currentUser,
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<UserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _isUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    print("the res is $res");
    res.fold(
      (l) {
        print("the error is ${l.message.toString()}");
        emit(AuthFailure(l.message));
      },
      (r) {
        print(
            "the name of the supabase user is ${r.name}, email is ${r.email}, and id is ${r.id} ");
        _emitAuthSuccess(r, emit);
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
