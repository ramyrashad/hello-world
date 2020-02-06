import 'package:dio/dio.dart';
import 'package:moia_services/core/error/exceptions.dart';
import 'package:moia_services/core/network/dio_service.dart';
import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:meta/meta.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';

abstract class AccountRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<UserViewModel> login(AccountBindingModel model);

  /// Throws a [ServerException] for all error codes.
  Future<AccountBindingModel> register(AccountBindingModel model);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final DioService dioService;

  AccountRemoteDataSourceImpl({@required this.dioService});

  @override
  Future<UserViewModel> login(AccountBindingModel model) async {
    Response response =
        await this.dioService.dio.post('token', data: model.toJson());
    return _getResponseData(response);
  }

  @override
  Future<AccountBindingModel> register(AccountBindingModel model) async {
    Response response = await this
        .dioService
        .dio
        .post<AccountBindingModel>('token', data: model.toJson());
    return response.data;
  }

  UserViewModel _getResponseData(Response response) {
    if (response.statusCode == 200)
      return UserViewModel.fromJson(response.data);
    else
      throw ServerException();
  }
}
