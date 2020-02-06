import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:moia_services/core/network/secure_data.dart';
import 'package:moia_services/core/util/settings.dart';

class MOIAInterceptor extends InterceptorsWrapper {
  static final String authorizationHeaderKey = "Authorization";

  final InterceptorSendCallback _onRequest;
  final InterceptorSuccessCallback _onResponse;
  final InterceptorErrorCallback _onError;
  final SecureData _secureData;
  final Dio _dio;

  Dio tokenDio = new Dio();
  RequestOptions _options;

  MOIAInterceptor(
      {InterceptorSendCallback onRequest,
      InterceptorSuccessCallback onResponse,
      InterceptorErrorCallback onError,
      @required SecureData secureData,
      @required Dio dio})
      : _onRequest = onRequest,
        _onResponse = onResponse,
        _onError = onError,
        _secureData = secureData,
        _dio = dio {
    _dio.options.baseUrl = Settings.API_URL;
    tokenDio.options = dio.options;
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (options.path == "token") {
      options.contentType = "application/x-www-form-urlencoded";
      options.headers[authorizationHeaderKey] = _secureData.getRefreshToken();
    } else
      options.headers[authorizationHeaderKey] = _secureData.getToken();
    _options = options;

    if (_onRequest != null) {
      return _onRequest(options);
    }
  }

  @override
  Future onResponse(Response response) async {
    if (_onResponse != null) {
      return _onResponse(response);
    }
  }

  @override
  Future onError(DioError err) async {
    if (err.response != null) {
      if (err.response?.statusCode == 401) {
        _dio.lock();
        _dio.interceptors.responseLock.lock();
        _dio.interceptors.errorLock.lock();

        return tokenDio
            .post("/token", data: {"grant_type": "refresh_token"}).then((d) {
          //update csrfToken
          _secureData.setSecureData(
              d.data['data']['access_token'], d.data['data']['refresh_token']);
          _options.headers[authorizationHeaderKey] = _secureData.getToken();
        }).whenComplete(() {
          _dio.unlock();
          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.errorLock.unlock();
        }).then((e) {
          //repeat
          return _dio.request(_options.path, options: _options);
        });
      } else
        return err.response;
    }

    if (_onError != null) {
      return _onError(err);
    }
  }
}
