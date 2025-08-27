import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioProvider {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Authorization': 'Bearer ${ApiConstants.accessToken}',
          'accept': 'application/json',
        },
      ),
    );
  }
}