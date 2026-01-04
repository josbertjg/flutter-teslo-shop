import 'package:dio/dio.dart';

import '../config.dart';

class ApiClient {
  ApiClient._(); // Constructor privado para evitar instanciación externa

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  // Instancia estática
  static Dio get instance => _dio;
}

final api = ApiClient.instance;
