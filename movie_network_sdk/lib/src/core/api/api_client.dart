import 'package:dio/dio.dart';

class ApiClient {
  final dio = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    final baseOption = BaseOptions(
        baseUrl: '',
        receiveTimeout: 15000, // * 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000);
    final dio = Dio(baseOption);

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  void functionType(Function function) {
    function();
  }

  void functionTypeWithParameters(Function() function) {
    function();
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // print('started call api');
    // print(options.uri);
    return handler.next(options);
  }
}
