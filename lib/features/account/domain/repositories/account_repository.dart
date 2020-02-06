import 'package:dartz/dartz.dart';
import 'package:moia_services/core/error/failures.dart';
import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';

abstract class AccountRepository {
  Future<Either<Failure, UserViewModel>> login(AccountBindingModel model);
  UserViewModel currentUser();
  void logOutUser();
}
