/* DioException errors */
class ConnectionTimeOut implements Exception {}

class SendTimeOut implements Exception {}

class ReceiveTimeOut implements Exception {}

class BadCertificate implements Exception {}

class BadResponse implements Exception {}

class Cancelled implements Exception {}

class ConnectionError implements Exception {}

class Unknown implements Exception {}

class UnexpectedError implements Exception {}

/* Status code errors */
class BadRequest implements Exception {}

class UnAuthorized implements Exception {}

class Forbidden implements Exception {}

class NotFound implements Exception {}

class MethodNotAllowed implements Exception {}

class InternalServerError implements Exception {}

class NotImplemented implements Exception {}

class BadGateway implements Exception {}

/* Custom errors */
// Generic custom errors
class NotHandled implements Exception {}

class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

// More specific custom errors
class CustomError implements Exception {
  final String message;

  CustomError({required this.message});
}
