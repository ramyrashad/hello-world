import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moia_services/core/bloc/navigation/bloc.dart';
import 'package:moia_services/core/localization/global_translations.dart';
import 'package:moia_services/features/account/presentation/login/widgets/loading_widget.dart';
import 'package:moia_services/features/account/presentation/login/widgets/login_controls.dart';
import 'package:moia_services/features/account/presentation/login/widgets/message_display.dart';
import 'package:moia_services/injection_container.dart';

import 'bloc/bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allTranslations.text('hello')),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: 'MOIA Login!');
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Logged) {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(OpenLoginScreen());
                  } else if (state is LoggingFailded) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else if (state is InputError) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              LoginControls()
            ],
          ),
        ),
      ),
    );
  }
}
