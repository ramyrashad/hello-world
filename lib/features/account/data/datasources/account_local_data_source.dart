import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';

abstract class AccountLocalDataSource {
  /// Throws a [CacheException] for all error codes.
  Future<UserViewModel> login(AccountBindingModel model);

  /// Throws a [CacheException] for all error codes.
  Future<AccountBindingModel> register(AccountBindingModel model);

  /// Throws a [CacheException] for all error codes.
  bool cachelogin(UserViewModel model);
}

class AccountLocalDataSourceImpl extends AccountLocalDataSource {
  @override
  bool cachelogin(UserViewModel model) {
    // TODO: implement cachelogin
    return null;
  }

  @override
  Future<UserViewModel> login(AccountBindingModel model) {
    // TODO: implement login
    return null;
  }

  @override
  Future<AccountBindingModel> register(AccountBindingModel model) {
    // TODO: implement register
    return null;
  }
}
