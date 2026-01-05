import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teslo_shop/features/shared/domain/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/error_handler/error_handler.dart';

import '../../../domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthBloc({required this.authRepository, required this.keyValueStorageService})
      : super(const AuthState()) {
    on<LoginUser>(_onLoginUser, transformer: droppable());
    on<RegisterUser>(_onRegisterUser);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutUser>(_onLogoutUser);

    checkAuthStatus();
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(
          email: event.email, password: event.password);
      await _setLoggedUser(user, emit);
    } catch (error) {
      ErrorHandler.handleException(error);
      logout("Credenciales no son correctas");
    }
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {}

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final token = await keyValueStorageService.getValue<String>("token");
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user, emit);
    } catch (error) {
      logout();
      ErrorHandler.handleException(error);
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    await keyValueStorageService.removeKey("token");
    emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: event.errorMessage));
  }

  Future<void> _setLoggedUser(User user, Emitter<AuthState> emit) async {
    await keyValueStorageService.setKeyValue("token", user.token);
    emit(state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: "",
    ));
  }

  void login(String email, String password) {
    add(LoginUser(email, password));
  }

  void logout([String? errorMessage]) {
    add(LogoutUser(errorMessage));
  }

  void checkAuthStatus() {
    add(CheckAuthStatus());
  }
}
