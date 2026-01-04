import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(AuthDatasource? datasource)
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login({required String email, required String password}) {
    return datasource.login(email: email, password: password);
  }

  @override
  Future<User> register(
      {required String email,
      required String fullName,
      required String password}) {
    return datasource.register(
        email: email, password: password, fullName: fullName);
  }
}
