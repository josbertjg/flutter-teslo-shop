import 'package:dio/dio.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/domain/error/failures.dart';
// import 'package:teslo_shop/features/shared/infrastructure/services/global_service.dart';

class ErrorHandler {
  static Exception throwException(Object error) {
    if (error is! DioException) throw UnexpectedErrorException();
    print(error);
    throw switch (error.type) {
      DioExceptionType.connectionTimeout => ConnectionTimeOutException(),
      DioExceptionType.sendTimeout => SendTimeOutException(),
      DioExceptionType.receiveTimeout => ReceiveTimeOutException(),
      DioExceptionType.badCertificate => BadCertificateException(),
      DioExceptionType.badResponse => _handleBadResponseException(error),
      DioExceptionType.cancel => CancelledException(),
      DioExceptionType.connectionError => ConnectionErrorException(),
      DioExceptionType.unknown => UnknownException(),
    };
  }

  static Exception _handleBadResponseException(DioException error) {
    throw switch (error.response?.statusCode) {
      400 => BadRequestException(),
      401 => UnAuthorizedException(),
      403 => ForbiddenException(),
      404 => NotFoundException(),
      405 => MethodNotAllowedException(),
      500 => InternalServerErrorException(),
      501 => NotImplementedException(),
      502 => BadGatewayException(),
      _ => NotHandledException()
    };
  }

  // static String handleException(Object error) {
  //   late final String errorText;

  //   if (error is CustomErrorException) {
  //     GlobalService.showSnackbar(error.message);
  //     return error.message;
  //   }

  //   // Error si la respuesta no llega y es una exception de Dio
  //   if (error is DioException && error.response == null) {
  //     errorText = "No hubo respuesta del servidor, inténtalo más tarde.";
  //     GlobalService.showSnackbar(errorText);
  //     return errorText;
  //   }

  //   // Errores custom
  //   errorText = switch (error) {
  //     // Errores de status
  //     BadRequestException() =>
  //       "Ocurrió un error de consulta, por favor inténtalo de nuevo. (BadRequest)",
  //     UnAuthorizedException() => "No permitido. (UnAuthorized)",
  //     ForbiddenException() =>
  //       "No tienes permiso para acceder a este recurso. (Forbidden)",
  //     NotFoundException() => "Recurso no encontrado. (NotFound)",
  //     MethodNotAllowedException() => "Método no permitido. (MethodNotAllowed)",
  //     InternalServerErrorException() =>
  //       "¡Ups! Ocurrió un error interno inesperado. (InternalServerError)",
  //     NotImplementedException() =>
  //       "Algo salió mal, por favor inténtalo de nuevo más tarde. (NotImplemented)",
  //     BadGatewayException() =>
  //       "Algo salió mal, por favor inténtalo de nuevo. (BadGateway)",

  //     // Errores de Dio fuera de la respuesta
  //     ConnectionTimeOutException() =>
  //       "Revisa tu conexión a internet, la conexión ha tardado mucho. (ConnectionTimeOut)",
  //     SendTimeOutException() =>
  //       "Revisa tu conexión a internet, no fue posible enviar la información. (SendTimeOut)",
  //     ReceiveTimeOutException() =>
  //       "Revisa tu conexión a internet, no fue posible recibir la información. (ReceiveTimeOut)",
  //     BadCertificateException() =>
  //       "El certificado incluido en la respuesta es inválido, porfavor vuelve a intentarlo más tarde. (BadCertificate)",
  //     CancelledException() =>
  //       "La solicitud ha sido cancelada, inténtalo de nuevo más tarde. (Cancelled)",
  //     ConnectionErrorException() =>
  //       "Ocurrió un error de conexión, porfavor vuelve a intentarlo. (ConnectionError)",
  //     UnknownException() =>
  //       "Ocurrió un error desconocido, inténtalo de nuevo más tarde. (Unknown)",

  //     // Errores personalizados
  //     NotHandledException() => "Ocurrió un error inesperado. (NotHandled)",
  //     WrongCredentialsException() => "Credenciales no válidas.",
  //     InvalidTokenException() => "Token no válido.",
  //     _ =>
  //       "Algo salió mal, inténtalo de nuevo mas tarde.", // Caso por defecto obligatorio
  //   };

  //   GlobalService.showSnackbar(errorText);
  //   return errorText;
  // }

  static Failure returnFailure(Object error) {
    if (error is CustomErrorException) return CustomErrorFailure(error.message);

    // Error si la respuesta no llega y es una exception de Dio
    if (error is DioException && error.response == null) {
      CustomErrorFailure(
          "No hubo respuesta del servidor, inténtalo más tarde.");
    }

    // Errores custom
    return switch (error) {
      // Errores de status
      BadRequestException() => BadRequestFailure(),
      UnAuthorizedException() => UnAuthorizedFailure(),
      ForbiddenException() => ForbiddenFailure(),
      NotFoundException() => NotFoundFailure(),
      MethodNotAllowedException() => MethodNotAllowedFailure(),
      InternalServerErrorException() => InternalServerErrorFailure(),
      NotImplementedException() => NotImplementedFailure(),
      BadGatewayException() => BadGatewayFailure(),

      // Errores de Dio fuera de la respuesta
      ConnectionTimeOutException() => ConnectionErrorFailure(),
      SendTimeOutException() => SendTimeOutFailure(),
      ReceiveTimeOutException() => ReceiveTimeOutFailure(),
      BadCertificateException() => BadCertificateFailure(),
      CancelledException() => CancelledFailure(),
      ConnectionErrorException() => ConnectionErrorFailure(),
      UnknownException() => UnknownFailure(),

      // Errores personalizados
      NotHandledException() => NotHandledFailure(),
      WrongCredentialsException() => WrongCredentialsFailure(),
      InvalidTokenException() => InvalidTokenFailure(),
      _ => CustomErrorFailure(
          "Algo salió mal, inténtalo de nuevo mas tarde."), // Caso por defecto obligatorio
    };
  }
}
