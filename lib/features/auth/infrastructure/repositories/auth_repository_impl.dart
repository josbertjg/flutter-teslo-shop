import 'package:dartz/dartz.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/domain/error/failures.dart';
import 'package:teslo_shop/features/shared/infrastructure/error_handler/error_handler.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl([AuthDatasource? datasource])
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<Either<Failure, User>> checkAuthStatus(String token) async {
    try {
      final user = await datasource.checkAuthStatus(token);
      return Right(user);
    } catch (error) {
      return Left(ErrorHandler.returnFailure(error));
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final user = await datasource.login(email: email, password: password);
      return Right(user);
    } catch (error) {
      return Left(ErrorHandler.returnFailure(error));
    }
  }

  @override
  Future<Either<Failure, User>> register(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      final user = await datasource.register(
          email: email, password: password, fullName: fullName);
      return Right(user);
    } catch (error) {
      return Left(ErrorHandler.returnFailure(error));
    }
  }
}
