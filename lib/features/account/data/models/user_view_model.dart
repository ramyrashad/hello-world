import 'package:moia_services/features/account/domain/entities/user.dart';
import 'package:meta/meta.dart';

class UserViewModel extends User {
  UserViewModel(
      {@required accessToken,
      @required tokenType,
      @required expiresIn,
      @required refreshToken,
      @required userName})
      : super(
            accessToken: accessToken,
            tokenType: tokenType,
            expiresIn: expiresIn,
            refreshToken: refreshToken,
            userName: userName);

  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        refreshToken: json['refresh_token'],
        userName: json['userName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'userName': userName
    };
  }
}
