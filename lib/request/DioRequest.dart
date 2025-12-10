import 'package:dio/dio.dart';
import 'package:my_app/constants/ApiConstant.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = ApiConstant.baseUrl
      ..connectTimeout = Duration(seconds: ApiConstant.timeout)
      ..receiveTimeout = Duration(seconds: ApiConstant.timeout)
      ..sendTimeout = Duration(seconds: ApiConstant.timeout);
    // interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 在发送请求之前做一些事情
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 检查 http 状态码
          if (response.statusCode != null &&
              response.statusCode! >= 200 &&
              response.statusCode! < 300) {
            // 检查业务状态码
            final data = response.data;
            if (data is Map && data['code'] == ApiConstant.successCode) {
              return handler.next(response);
            } else {
              // 业务错误
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  type: DioExceptionType.badResponse,
                  message: data is Map ? data['msg'] : 'Unknown Error',
                ),
              );
            }
          } else {
            // HTTP 错误 (虽然通常 Dio 会在 onError 处理非 2xx，但这里保留逻辑)
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                type: DioExceptionType.badResponse,
                message: response.statusMessage,
              ),
            );
          }
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<T?> get<T>(
    String strurl, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(strurl, queryParameters: queryParameters);
      return response.data['result'] as T?;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: strurl),
        error: e,
        type: DioExceptionType.unknown,
        message: e.toString(),
      );
    }
  }

  Future<T?> post<T>(String strurl, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(strurl, data: data);
      return response.data['result'] as T?;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: strurl),
        error: e,
        type: DioExceptionType.unknown,
        message: e.toString(),
      );
    }
  }
}

// singleton pattern
final dioRequest = DioRequest();
