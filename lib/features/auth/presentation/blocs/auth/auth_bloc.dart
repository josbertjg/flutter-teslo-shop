import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teslo_shop/features/shared/infrastructure/error_handler/error_handler.dart';

import '../../../domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(const AuthState()) {
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
      _handleUserAuthenticated(user, emit);
    } catch (error) {
      ErrorHandler.handleException(error);
      _handleLogout(emit, "Credenciales no son correctas");
    }
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {}
  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {}

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    // TODO: Limpiar token
    _handleLogout(
      emit,
      event.errorMessage,
    );
  }

  void _handleUserAuthenticated(User user, Emitter<AuthState> emit) {
    // TODO: Necesito guardar el token físicamente
    emit(state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    ));
  }

  void _handleLogout(Emitter<AuthState> emit, [String? errorMessage]) {
    emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage));
  }

  void loginUser(String email, String password) {
    add(LoginUser(email, password));
  }
}
