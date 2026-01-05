import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';
// Importas tus repositorios y blocs...

class AppInjection {
  /// Este método envuelve el widget raíz (MyApp) con todos los
  /// proveedores que deben ser globales.
  static Widget configure({required Widget child}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepositoryImpl()),
        RepositoryProvider(create: (context) => KeyValueStorageServiceImpl()),
        // RepositoryProvider(create: (context) => PaymentRepository()),
        // RepositoryProvider(create: (context) => PaymentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepositoryImpl>(),
                  keyValueStorageService:
                      context.read<KeyValueStorageServiceImpl>())),
          // BlocProvider(
          //   create: (context) => AuthBloc(
          //     repository: context.read<AuthRepository>(),
          //   )..add(AppCheckStatus()),
          // ),
          // BlocProvider(create: (context) => NotificationBloc()),
        ],
        child: child,
      ),
    );
  }
}
