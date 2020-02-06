import 'package:dartz/dartz.dart';
import 'package:moia_services/core/error/failures.dart';
import 'package:moia_services/core/network/network_info.dart';
import 'package:moia_services/features/account/data/datasources/account_local_data_source.dart';
import 'package:moia_services/features/account/data/datasources/account_remote_data_source.dart';
import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';
import 'package:moia_services/features/account/domain/repositories/account_repository.dart';
import 'package:moia_services/core/error/exceptions.dart';
import 'package:meta/meta.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserViewModel>> login(
      AccountBindingModel model) async {
        if(await this.networkInfo.isConnected)
        {
    try {
      final userViewModel = await remoteDataSource.login(model);
// To Do ++

      localDataSource.cachelogin(userViewModel);
      return Right(userViewModel);
    } on ServerException {
      return Left(ServerFailure());
    }
        }
  }

  @override
  UserViewModel currentUser() {
    // TODO: implement currentUser
    return null;
  }

  @override
  void logOutUser() {
    // TODO: implement logOutUser
  }
}
