part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;
  const LoginUser(this.email, this.password);
}

class RegisterUser extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  const RegisterUser(this.email, this.password, this.fullName);
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class LogoutUser extends AuthEvent {
  final String? errorMessage;
  const LogoutUser([this.errorMessage]);
}
