/* Dio Exceptions */
class ConnectionTimeOutException implements Exception {}

class SendTimeOutException implements Exception {}

class ReceiveTimeOutException implements Exception {}

class BadCertificateException implements Exception {}

class BadResponseException implements Exception {}

class CancelledException implements Exception {}

class ConnectionErrorException implements Exception {}

class UnknownException implements Exception {}

class UnexpectedErrorException implements Exception {}

/* Status code exceptions */
class BadRequestException implements Exception {}

class UnAuthorizedException implements Exception {}

class ForbiddenException implements Exception {}

class NotFoundException implements Exception {}

class MethodNotAllowedException implements Exception {}

class InternalServerErrorException implements Exception {}

class NotImplementedException implements Exception {}

class BadGatewayException implements Exception {}

/* Custom exceptions */
// Generic custom exceptions
class NotHandledException implements Exception {}

class WrongCredentialsException implements Exception {}

class InvalidTokenException implements Exception {}

// More specific custom exception
class CustomErrorException implements Exception {
  final String message;

  CustomErrorException({required this.message});
}
