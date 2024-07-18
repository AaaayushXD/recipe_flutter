import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _singleton = HttpService._internal();

  final _dio = Dio();
  factory HttpService() {
    return _singleton;
  }

  HttpService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {"Content-Type": "application/json"};
    final options = BaseOptions(
        headers: headers,
        baseUrl: "https://dummyjson.com/",
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });
    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Response?>? get(String path) {
    try {
      final response = _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
