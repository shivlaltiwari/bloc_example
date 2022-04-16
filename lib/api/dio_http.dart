import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'ihttp.dart';

class DioHttp implements IHttp {
  late Dio dio;

  DioHttp() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 12000,
      receiveTimeout: 12000,
    );
    dio = Dio(options);
    if (!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  @override
  get(String url, {String? token, Map<String, dynamic>? queryParams}) async {
    return dio.get(
      url,
      options: Options(headers: {"Authorization": "Bearer $token"}),
      queryParameters: queryParams,
    );
  }

  @override
  delete(String url) {
    throw UnimplementedError();
  }

  @override
  patch(String url, Map data) {
    throw UnimplementedError();
  }

  @override
  post(String url, Map data, {String? token}) async {
    return dio.post(url,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }
}
