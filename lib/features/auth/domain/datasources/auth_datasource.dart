import 'package:teslo_shop/features/auth/domain/entities/entities.dart';

abstract class AuthDatasource {
  Future<User> login({required String email, required String password});
  Future<User> register(
      {required String email,
      required String fullName,
      required String password});
  Future<User> checkAuthStatus(String token);
}
