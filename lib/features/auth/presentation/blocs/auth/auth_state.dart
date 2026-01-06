part of 'auth_bloc.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final bool isLoading;

  const AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = "",
      this.isLoading = false});

  AuthState copyWith(
          {AuthStatus? authStatus,
          User? user,
          String? errorMessage,
          bool? isLoading}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object?> get props => [authStatus, user, errorMessage, isLoading];
}
