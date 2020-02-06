import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moia_services/core/localization/global_translations.dart';
import 'package:moia_services/core/localization/locale_helper.dart';
import 'package:moia_services/features/account/presentation/login/bloc/bloc.dart';

class LoginControls extends StatefulWidget {
  const LoginControls({
    Key key,
  }) : super(key: key);

  @override
  _LoginControlsState createState() => _LoginControlsState();
}

class _LoginControlsState extends State<LoginControls> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: usernameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText:  allTranslations.text('username'),
          ),
          maxLength: 11,
          onChanged: (value) {
            username = value;
          },
          onSubmitted: (_) {
            dispatchLogin();
          },
        ),
        SizedBox(height: 10),
        TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: allTranslations.text('password'),
            ),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            onSubmitted: (_) {
              dispatchLogin();
            }),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(allTranslations.text('login')),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchLogin,
              ),
            )
          ],
        ), Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(allTranslations.text('change_language')),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchLanguage,
              ),
            )
          ],
        )
      ],
    );
  }

  void dispatchLogin() {
    usernameController.clear();
    passwordController.clear();
    BlocProvider.of<LoginBloc>(context).add(GetLoginUser(username, password));
  }

  void dispatchLanguage() {
    var userLanguage = allTranslations.locale;
    if(userLanguage.languageCode == "ar")
    {
      allTranslations.setPreferredLanguage("en");
       helper.onLocaleChanged(new Locale("en"));
    }
    else
    {
      allTranslations.setPreferredLanguage("ar");
       helper.onLocaleChanged(new Locale("ar"));
    }
    
  }
}
