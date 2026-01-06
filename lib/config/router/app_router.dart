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
      final isGoingTo = state.matchedLocation;
      final authStatus = authBloc.state.authStatus;

      // Si va al splash screen y se esta chequeando el auth status entonces se le permite estar alli
      if (isGoingTo == "/splash" && authStatus == AuthStatus.checking) {
        return null;
      }

      // Si no esta autenticado, verifico a donde quiere ir
      if (authStatus == AuthStatus.notAuthenticated) {
        // Si quiere ir a login o register se le permite porque no esta autenticado
        if (isGoingTo == "/login" || isGoingTo == "/register") return null;

        return "/login"; // De ñp contrario, si quiere ir a alguna otra ruta se le obliga a redirigirse siempre a login
      }

      // Si esta autenticado verifico a donde quiere ir
      if (authStatus == AuthStatus.authenticated) {
        // Si estando autenticado quiere ir a login, register o al splash entonces se le obliga a estar siempre en el root
        if (isGoingTo == "/login" ||
            isGoingTo == "/register" ||
            isGoingTo == "/splash") {
          return "/";
        }

        return null; // Caso contrario, se le permite ir a donde quiera
      }

      // Ya en este punto, todas mis rutas estaran validadas
      return null;
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
