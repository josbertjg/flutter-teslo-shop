import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
// Importas tus repositorios y blocs...

class AppInjection {
  /// Este método envuelve el widget raíz (MyApp) con todos los
  /// proveedores que deben ser globales.
  static Widget configure({required Widget child}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepositoryImpl()),
        // RepositoryProvider(create: (context) => DoctorRepository()),
        // RepositoryProvider(create: (context) => PaymentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepositoryImpl>())),
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
