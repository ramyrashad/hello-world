import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String userName;

  User({
    @required this.accessToken,
    @required this.tokenType,
    @required this.expiresIn,
    @required this.refreshToken,
    @required this.userName,
  });

  @override
  List<Object> get props =>
      [accessToken, tokenType, expiresIn, refreshToken, userName];
}
