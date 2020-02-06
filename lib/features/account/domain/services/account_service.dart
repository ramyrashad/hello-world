import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:moia_services/core/database/moor_database.dart';
import 'package:moia_services/core/error/failures.dart';
import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';
import 'package:moia_services/features/account/domain/repositories/account_repository.dart';

class AccountService {
  final AccountRepository repository;

  AccountService({@required this.repository});

  Future<Either<Failure, UserViewModel>> login(
      AccountBindingModel model) async {
          return await repository.login(model);
  }

  UserViewModel getCurrentUser()
  {
 return repository.currentUser();
  }
}
