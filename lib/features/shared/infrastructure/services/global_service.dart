import 'package:flutter/material.dart';

class GlobalService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showSnackbar(String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showMaterialBanner() {
    GlobalService.messengerKey.currentState?.showMaterialBanner(
      MaterialBanner(
        content: Text('No tienes conexión a internet'),
        actions: [
          TextButton(onPressed: () => {}, child: Text('REINTENTAR')),
        ],
      ),
    );
  }

  static void showBottomSheet(/*Widget content*/) {
    // Obtenemos el contexto actual a través de la llave del navegador
    final context = navigatorKey.currentContext;

    if (context != null) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Text("hola mundo"),
      );
    }
  }

  static Future<void> showGlobalDialog({
    required String title,
    required String message,
  }) async {
    final context = navigatorKey.currentContext;

    if (context != null) {
      return showDialog(
        context: context,
        // Evita que se cierre al tocar fuera (opcional)
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text("Cerrar"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica adicional (ej: reintentar)
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        },
      );
    }
  }
}
