import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moia_services/core/network/Interceptor.dart';
import 'package:moia_services/core/network/secure_data.dart';
import 'package:moia_services/core/util/settings.dart';

class DioService {
  final SecureData _secureData;
  Dio _dio;

  DioService({@required SecureData secureData}) : _secureData = secureData {
    this._getInstance();
  }

  _getInstance() {
    _dio = new Dio();
    dio.options.baseUrl = Settings.API_URL;
    _dio.interceptors
        .add(MOIAInterceptor(secureData: this._secureData, dio: this._dio));
  }

  Dio get dio {
    return _dio;
  }
}
