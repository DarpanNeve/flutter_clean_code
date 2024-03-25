part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uId;

  AuthSuccess(this.uId);
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
