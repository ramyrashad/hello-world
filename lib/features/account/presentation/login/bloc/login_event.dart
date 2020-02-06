import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class GetLoginUser extends LoginEvent {
  final String username;
  final String password;

  GetLoginUser(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
