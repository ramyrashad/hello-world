import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureData {
  final FlutterSecureStorage storage;
  String _token = "";
  String _refreshToken = "";

  SecureData({@required this.storage});

  Future<String> getToken() async {
    if (_token == "") {
      _token = await storage.read(key: 'token');
      if (_token == null) _token = "";
    }
    return _token;
  }

  Future<String> getRefreshToken() async {
    if (_refreshToken == "") {
      _refreshToken = await storage.read(key: 'refreshToken');
      if (_refreshToken == null) _refreshToken = "";
    }
    return _refreshToken;
  }

  void setSecureData(String token, String refreshToken) async {
    _token = token;
    _refreshToken = refreshToken;
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }
}
