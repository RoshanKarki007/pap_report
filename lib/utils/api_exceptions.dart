import "dart:async";
import "dart:convert";
import "dart:io";
import "package:dio/dio.dart";

class ApiException implements Exception {
  late final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  static ApiException getApiException(dynamic ex) {
    if (ex is DioException) {
      var exceptionMessage = "";
      try {
        if (ex.response != null) {
          if (ex.response!.data.runtimeType == String) {
            var decodedMessage = jsonDecode(ex.response?.data);
            if (decodedMessage["message"] != null &&
                decodedMessage["message"].toString().isNotEmpty) {
              exceptionMessage = decodedMessage["message"];
            } else {
              exceptionMessage = decodedMessage["error"] ??
                  decodedMessage["responseData"]["errors"][0]["errorMessage"];
            }
          } else {
            String? errorMessage;
            try {
              errorMessage =
                  (ex.response!.data["errors"][0] as Map<String, dynamic>)
                      .values
                      .first;
            } catch (e) {
              errorMessage = null;
            }
            return ApiException(
              errorMessage ??
                  ex.response!.data["message"] ??
                  ex.response!.data["error"] ??
                  ex.response!.data["responseData"]["errors"][0]
                      ["errorMessage"],
              statusCode: ex.response?.statusCode,
            );
          }
        } else if (ex.error.runtimeType == SocketException) {
          return ApiException(
              'Internet connection is not available, Please try again later',
              statusCode: ex.response?.statusCode);
        } else {
          exceptionMessage = 'Internal Server Error, Please try again later';
        }
      } catch (ex) {
        exceptionMessage = 'Internal Server Error, Please try again later';
      }
      return ApiException(exceptionMessage,
          statusCode: ex.response?.statusCode);
    } else if (ex.runtimeType == String) {
      return ApiException(ex, statusCode: ex.response?.statusCode);
    } else if (ex.runtimeType == TimeoutException) {
      return ApiException('Connection Timeout, Please try again later',
          statusCode: -1);
    }
    try {
      return ApiException('Internal Server Error, Please try again later',
          statusCode: ex.response?.statusCode ?? -1);
    } catch (ex) {
      return ApiException(ex.toString(), statusCode: -1);
    }
  }
}
