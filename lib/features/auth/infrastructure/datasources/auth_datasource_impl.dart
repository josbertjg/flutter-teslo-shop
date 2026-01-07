import 'package:dio/dio.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/error_handler/error_handler.dart';
import '../../../../config/config.dart';
import '../../domain/domain.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await api.get("/auth/check-status",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (error) {
      throw InvalidTokenException();
    }
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await api
          .post("/auth/login", data: {"email": email, "password": password});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 401) {
        throw WrongCredentialsException();
      }
      throw ErrorHandler.throwException(error);
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
