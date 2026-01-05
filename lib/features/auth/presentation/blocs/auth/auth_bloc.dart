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
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(
          email: event.email, password: event.password);
      await _handleUserAuthentication(user, emit);
    } catch (error) {
      ErrorHandler.handleException(error);
      await _handleLogout(emit, "Credenciales no son correctas");
    }
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {}
  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {}

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    await _handleLogout(
      emit,
      event.errorMessage,
    );
  }

  Future<void> _handleUserAuthentication(User user, Emitter<AuthState> emit) async {
    await keyValueStorageService.setKeyValue("token", user.token);
    emit(state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: "",
    ));
  }

  Future<void> _handleLogout(Emitter<AuthState> emit, [String? errorMessage]) async {
    await keyValueStorageService.removeKey("token");
    emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage));
  }

  void loginUser(String email, String password) {
    add(LoginUser(email, password));
  }
}
