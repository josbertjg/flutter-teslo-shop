import 'package:flutter/material.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/config/injection/app_injection.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/global_service.dart';

void main() async {
  await Enviroment.initEnviroment();
  runApp(AppInjection.configure(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: GlobalService.messengerKey,
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
