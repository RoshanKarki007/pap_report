import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:pap_report/constants/request_type.dart";

class ApiClient {
  static final instance = ApiClient._();
  factory ApiClient() {
    return instance;
  }
  late final Dio _dio;
  final timeOutDuration = const Duration(seconds: kDebugMode ? 60 : 120);

  ApiClient._() {
    _dio = Dio();
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
            responseBody: true,
            requestHeader: true,
            responseHeader: true,
            requestBody: true,
            error: true,
            request: true),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          return handler.next(error);
        },
        onResponse: (options, handler) {
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> request({
    required RequestType requestType,
    required String url,
    dynamic parameter,
    dynamic queryParameters,
    dynamic headers,
  }) async {
    Map<String, String> heading = {
      "source": "SELF",
      "Content-Type": "application/json",
      "accept": "*/*",
      "Connection": "Keep-Alive",
    };

    switch (requestType) {
      case RequestType.get:
        return _dio
            .get(
              url,
              data: parameter,
              options: Options(
                headers: heading,
                receiveTimeout: timeOutDuration,
              ),
              queryParameters: queryParameters,
            )
            .timeout(timeOutDuration);
      case RequestType.post:
        return _dio
            .post(
              url.trim(),
              data: jsonEncode(parameter),
              options: Options(
                headers: heading,
                receiveTimeout: timeOutDuration,
              ),
              queryParameters: queryParameters,
            )
            .timeout(timeOutDuration);
    }
  }
}
