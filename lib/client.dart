import 'package:dio/dio.dart';

class Client{
  String url = "https://hassanschool.com/v1/api/";

  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    _dio.options.baseUrl = url;
    return _dio;
  }
}


class ApiInterceptors extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("onRequest : ${options.data}");
    super.onRequest(options, handler);
  }

 @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
   print("onError : ${err.message}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("onResponse ${response.data}");
    super.onResponse(response, handler);
  }
}