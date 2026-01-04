import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await api
          .post("/auth/login", data: {"email": email, "password": password});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (error) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(
      {required String email,
      required String fullName,
      required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
