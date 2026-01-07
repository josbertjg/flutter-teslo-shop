import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/* DioException errors */
class ConnectionTimeOutFailure extends Failure {
  const ConnectionTimeOutFailure()
      : super(
            "Revisa tu conexión a internet, la conexión ha tardado mucho. (ConnectionTimeOut)");
}

class SendTimeOutFailure extends Failure {
  const SendTimeOutFailure()
      : super(
            "Revisa tu conexión a internet, no fue posible enviar la información. (SendTimeOut)");
}

class ReceiveTimeOutFailure extends Failure {
  const ReceiveTimeOutFailure()
      : super(
            "Revisa tu conexión a internet, no fue posible recibir la información. (ReceiveTimeOut)");
}

class BadCertificateFailure extends Failure {
  const BadCertificateFailure()
      : super(
            "El certificado incluido en la respuesta es inválido, porfavor vuelve a intentarlo más tarde. (BadCertificate)");
}

class BadResponseFailure extends Failure {
  const BadResponseFailure()
      : super(
            "Ocurrió un error en la respuesta, inténtalo de nuevo más tarde. (BadResponse)");
}

class CancelledFailure extends Failure {
  const CancelledFailure()
      : super(
            "La solicitud ha sido cancelada, inténtalo de nuevo más tarde. (Cancelled)");
}

class ConnectionErrorFailure extends Failure {
  const ConnectionErrorFailure()
      : super(
            "Ocurrió un error de conexión, porfavor vuelve a intentarlo. (ConnectionError)");
}

class UnknownFailure extends Failure {
  const UnknownFailure()
      : super(
            "Ocurrió un error desconocido, inténtalo de nuevo más tarde. (Unknown)");
}

class UnexpectedErrorFailure extends Failure {
  const UnexpectedErrorFailure()
      : super(
            "Ocurrió un error inesperado, porfavor, inténtalo de nuevo más tarde.");
}

/* Status code errors */
class BadRequestFailure extends Failure {
  const BadRequestFailure()
      : super(
            "Ocurrió un error de consulta, por favor inténtalo de nuevo. (BadRequest)");
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure() : super("No permitido. (UnAuthorized)");
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure()
      : super("No tienes permiso para acceder a este recurso. (Forbidden)");
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super("Recurso no encontrado. (NotFound)");
}

class MethodNotAllowedFailure extends Failure {
  const MethodNotAllowedFailure()
      : super("Método no permitido. (MethodNotAllowed)");
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure()
      : super(
            "¡Ups! Ocurrió un error interno inesperado. (InternalServerError)");
}

class NotImplementedFailure extends Failure {
  const NotImplementedFailure()
      : super(
            "Algo salió mal, por favor inténtalo de nuevo más tarde. (NotImplemented)");
}

class BadGatewayFailure extends Failure {
  const BadGatewayFailure()
      : super("Algo salió mal, por favor inténtalo de nuevo. (BadGateway)");
}

/* Custom errors */
// Generic custom errors
class NotHandledFailure extends Failure {
  const NotHandledFailure()
      : super("Ocurrió un error inesperado. (NotHandled)");
}

class WrongCredentialsFailure extends Failure {
  const WrongCredentialsFailure() : super("Credenciales no válidas.");
}

class InvalidTokenFailure extends Failure {
  const InvalidTokenFailure() : super("Token no válido.");
}

// More specific custom errors
class CustomErrorFailure extends Failure {
  const CustomErrorFailure(super.message);
}
