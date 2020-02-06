import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_service.dart';
import 'core/network/network_info.dart';
import 'core/network/secure_data.dart';
import 'core/util/input_converter.dart';
import 'core/util/input_validation.dart';
import 'features/account/data/datasources/account_local_data_source.dart';
import 'features/account/data/datasources/account_remote_data_source.dart';
import 'features/account/data/repositories/account_repository_impl.dart';
import 'features/account/domain/repositories/account_repository.dart';
import 'features/account/domain/services/account_service.dart';
import 'features/account/presentation/login/bloc/login_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - ....

  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      accountService: sl(),
      inputConverter: sl(),
      inputValidation: sl(),
    ),
  );

  // Services
  sl.registerLazySingleton(() => AccountService(repository: sl()));

  // Repository
  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(dioService: sl()),
  );

  sl.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => InputValidation());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final storage = new FlutterSecureStorage();
  sl.registerLazySingleton(() => storage);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => SecureData(storage: sl()));
  sl.registerLazySingleton(() => DioService(secureData: sl()));
  sl.registerLazySingleton(() => Connectivity());
}
