import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Account extends Equatable {
  final String username;
  final String password;

  Account({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
