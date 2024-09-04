import 'dart:async';

import 'package:dio/dio.dart';

abstract class NetworkUtils {
  static Dio _dio = Dio();
  static const String _apiKey = '29df222a061b1f35ae1774357af363ad';

  static Future<void> init() async {
    _dio.options = BaseOptions(
      baseUrl: "https://api.openweathermap.org/data/2.5/",
      validateStatus: (status) => true,
      queryParameters: {'appid': _apiKey},
    );
  }

  static Future<Response> get(String path) async {
    return _dio.get(path);
  }
}
