import 'package:dartz/dartz.dart';
import 'package:teslo_shop/features/auth/domain/entities/entities.dart';
import 'package:teslo_shop/features/shared/domain/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, User>> register(
      {required String email,
      required String fullName,
      required String password});
  Future<Either<Failure, User>> checkAuthStatus(String token);
}
