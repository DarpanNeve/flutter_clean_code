part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  AppUserLoggedIn(this.user);
}

//CORE CANNOT DEPEND ON OTHER FEATURES
//BUT OTHER FEATURE CAN DEPEND ON CORE
