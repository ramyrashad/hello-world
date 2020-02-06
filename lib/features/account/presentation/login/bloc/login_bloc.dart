import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:moia_services/core/error/failures.dart';
import 'package:moia_services/core/localization/global_translations.dart';
import 'package:moia_services/core/util/input_converter.dart';
import 'package:moia_services/core/util/input_validation.dart';
import 'package:moia_services/features/account/data/models/account_binding_model.dart';
import 'package:moia_services/features/account/data/models/user_view_model.dart';
import 'package:moia_services/features/account/domain/services/account_service.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountService accountService;
  final InputConverter inputConverter;
  final InputValidation inputValidation;

  LoginBloc({
    @required this.accountService,
    @required this.inputConverter,
    @required this.inputValidation,
  })  : assert(accountService != null),
        assert(inputConverter != null),
        assert(inputValidation != null);

  @override
  LoginState get initialState => Empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is GetLoginUser) {
      final username = event.username;
      final password = event.password;
      final accountBindingModel =
          new AccountBindingModel(username: username, password: password);

      final inputEither = loginFormValidation(accountBindingModel);

      yield* inputEither.fold(
        (failure) async* {
          yield InputError(message: allTranslations.text('input_error'));
        },
        (integer) async* {
          yield Loading();
          final failureOrLogin =
              await accountService.login(accountBindingModel);
          yield* _eitherLoadedOrErrorState(failureOrLogin);
        },
      );
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, UserViewModel> failureOrLogin,
  ) async* {
    yield failureOrLogin.fold(
      (failure) => LoggingFailded(message: _mapFailureToMessage(failure)),
      (userViewModel) => Logged(user: userViewModel),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return allTranslations.text('server_failure');
      case CacheFailure:
        return allTranslations.text('cache_failure');
      default:
         return allTranslations.text('unexpected_error');
    }
  }

  Either<Failure, bool> loginFormValidation(AccountBindingModel model) {
      bool isValid = true;
      isValid = inputValidation.required(model.password);
      if (isValid) isValid = inputValidation.required(model.username);
      if (!isValid)  return Left(InvalidInputFailure());
      return Right(true);
  }
}
