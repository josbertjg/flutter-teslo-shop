part of 'login_form_cubit.dart';

enum LoginFormStatus { valid, invalid, validating, posting, posted }

class LoginFormState extends Equatable {
  final LoginFormStatus status;
  final bool isValid;
  final Email email;
  final Password password;

  const LoginFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = LoginFormStatus.invalid,
      this.isValid = false});

  LoginFormState copyWith(
          {Email? email,
          Password? password,
          bool? isValid,
          LoginFormStatus? status}) =>
      LoginFormState(
          email: email ?? this.email,
          password: password ?? this.password,
          isValid: isValid ?? this.isValid,
          status: status ?? this.status);

  @override
  String toString() {
    return '''
  LoginFormState:
  status: $status,
  isValid: $isValid,
  email: $email,
  password: $password,
''';
  }

  @override
  List<Object> get props => [email, password, isValid, status];
}
