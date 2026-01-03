import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormState());

  void onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;

    print(state);
  }

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    emit(state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.password]),
        status: Formz.validate([newEmail, state.password])
            ? LoginFormStatus.valid
            : LoginFormStatus.invalid));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    emit(state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]),
        status: Formz.validate([newPassword, state.email])
            ? LoginFormStatus.valid
            : LoginFormStatus.invalid));
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
        status: LoginFormStatus.posted,
        email: email,
        password: password,
        isValid: Formz.validate([email, password])));
  }
}
