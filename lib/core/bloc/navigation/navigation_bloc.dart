import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => SplashScreenState();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
     if(event is OpenSplashScreen )
     yield SplashScreenState();
    if(event is OpenHomeScreen )
     yield HomeScreenState();
     else if (event is OpenLoginScreen )
     yield LoginScreenState();
     else if (event is OpenRegistrationScreen )
     yield RegistrationScreenState();
  }
}
