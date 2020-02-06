import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/bloc/navigation/bloc.dart';
import 'core/localization/global_translations.dart';
import 'core/localization/locale_helper.dart';
import 'core/localization/translations.dart';
import 'features/account/presentation/login/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/splash/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  await di.init();
  runApp(
    BlocProvider<NavigationBloc>(
        create: (context) {
          return NavigationBloc()..add(OpenSplashScreen());
        },
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TranslationsDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    var langCode = allTranslations.locale.languageCode;
    if (langCode == '' || langCode == null) langCode = "en";
    _specificLocalizationDelegate = TranslationsDelegate(new Locale(langCode));
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new TranslationsDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        title: allTranslations.text('hello'),
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
          accentColor: Colors.green.shade600,
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'QA'),
        ],
        localizationsDelegates: [
          _specificLocalizationDelegate,
          new FallbackCupertinoLocalisationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: _specificLocalizationDelegate.overriddenLocale,
        home: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is HomeScreenState) {
              return HomePage();
            }
            if (state is LoginScreenState) {
              return LoginScreen();
            }
            if (state is RegistrationScreenState) {
              return LoginScreen();
            }

            Timer(Duration(seconds: 3), () {
              handleTimeout();
            });

            return SplashScreen();
          },
        ),
      ),
    );
  }

  void handleTimeout() {
    BlocProvider.of<NavigationBloc>(context).add(OpenLoginScreen());
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
