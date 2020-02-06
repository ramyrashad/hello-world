import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent {}

class OpenSplashScreen extends NavigationEvent {}

class OpenLoginScreen extends NavigationEvent {}

class OpenRegistrationScreen extends NavigationEvent {}

class OpenHomeScreen extends NavigationEvent {}
