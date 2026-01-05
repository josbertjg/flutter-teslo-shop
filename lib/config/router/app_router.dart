import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/products/products.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/global_service.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final router = GoRouter(
    navigatorKey: GlobalService.navigatorKey,
    refreshListenable: _GoRouterRefreshStream(
        authBloc.stream.map((state) => state.authStatus)),
    initialLocation: '/splash',
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
    redirect: (context, state) {
      print(state.fullPath);
      return "/login";
    },
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<AuthStatus> stream) {
    notifyListeners();
    //TODO: No disparar el notifyListeners si el estado del authStatus es el mismo que tenia anteriormente
    _subscription = stream.listen((AuthStatus status) {
      print('🔄 AuthStatus cambió a: $status - Notificando a GoRouter...');
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthStatus> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
