import 'package:dio/dio.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/global_service.dart';

class ErrorHandler {
  static Exception throwException(Object error) {
    if (error is! DioException) throw UnexpectedError();
    print(error);
    throw switch (error.type) {
      DioExceptionType.connectionTimeout => ConnectionTimeOut(),
      DioExceptionType.sendTimeout => SendTimeOut(),
      DioExceptionType.receiveTimeout => ReceiveTimeOut(),
      DioExceptionType.badCertificate => BadCertificate(),
      DioExceptionType.badResponse => _handleBadResponseException(error),
      DioExceptionType.cancel => Cancelled(),
      DioExceptionType.connectionError => ConnectionError(),
      DioExceptionType.unknown => Unknown(),
    };
  }

  static Exception _handleBadResponseException(DioException error) {
    throw switch (error.response?.statusCode) {
      400 => BadRequest(),
      401 => UnAuthorized(),
      403 => Forbidden(),
      404 => NotFound(),
      405 => MethodNotAllowed(),
      500 => InternalServerError(),
      501 => NotImplemented(),
      502 => BadGateway(),
      _ => NotHandled()
    };
  }

  static String handleException(Object error) {
    late final String errorText;

    if (error is CustomError) {
      GlobalService.showSnackbar(error.message);
      return error.message;
    }

    // Error si la respuesta no llega y es una exception de Dio
    if (error is DioException && error.response == null) {
      errorText = "No hubo respuesta del servidor, inténtalo más tarde.";
      GlobalService.showSnackbar(errorText);
      return errorText;
    }

    // Errores custom
    errorText = switch (error) {
      // Errores de status
      BadRequest() =>
        "Ocurrió un error de consulta, por favor inténtalo de nuevo. (BadRequest)",
      UnAuthorized() => "No permitido. (UnAuthorized)",
      Forbidden() =>
        "No tienes permiso para acceder a este recurso. (Forbidden)",
      NotFound() => "Recurso no encontrado. (NotFound)",
      MethodNotAllowed() => "Método no permitido. (MethodNotAllowed)",
      InternalServerError() =>
        "¡Ups! Ocurrió un error interno inesperado. (InternalServerError)",
      NotImplemented() =>
        "Algo salió mal, por favor inténtalo de nuevo más tarde. (NotImplemented)",
      BadGateway() =>
        "Algo salió mal, por favor inténtalo de nuevo. (BadGateway)",

      // Errores de Dio fuera de la respuesta
      ConnectionTimeOut() =>
        "Revisa tu conexión a internet, la conexión ha tardado mucho. (ConnectionTimeOut)",
      SendTimeOut() =>
        "Revisa tu conexión a internet, no fue posible enviar la información. (SendTimeOut)",
      ReceiveTimeOut() =>
        "Revisa tu conexión a internet, no fue posible recibir la información. (ReceiveTimeOut)",
      BadCertificate() =>
        "El certificado incluido en la respuesta es inválido, porfavor vuelve a intentarlo más tarde. (BadCertificate)",
      Cancelled() =>
        "La solicitud ha sido cancelada, inténtalo de nuevo más tarde. (Cancelled)",
      ConnectionError() =>
        "Ocurrió un error de conexión, porfavor vuelve a intentarlo. (ConnectionError)",
      Unknown() =>
        "Ocurrió un error desconocido, inténtalo de nuevo más tarde. (Unknown)",

      // Errores personalizados
      NotHandled() => "Ocurrió un error inesperado. NotHandled",
      WrongCredentials() => "Credenciales no válidas.",
      InvalidToken() => "Token no válido.",
      _ =>
        "Algo salió mal, inténtalo de nuevo mas tarde.", // Caso por defecto obligatorio
    };

    GlobalService.showSnackbar(errorText);
    return errorText;
  }
}
