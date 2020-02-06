import 'package:meta/meta.dart';

@immutable
abstract class NavigationState {}
  
class SplashScreenState extends NavigationState {}

class LoginScreenState extends NavigationState {}

class RegistrationScreenState extends NavigationState {}

class HomeScreenState extends NavigationState {}
