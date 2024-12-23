import 'package:dio/dio.dart';

class CustomDio {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.nasa.gov/planetary', queryParameters: {
    'api_key': const String.fromEnvironment('apikey'),
  }));
}
