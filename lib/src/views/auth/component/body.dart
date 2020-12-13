import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/views/auth/component/background.dart';
import 'package:myevent/src/widgets/roundedButton.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginState) {
            Navigator.of(context).pushNamed('/login');
          }
          if (state is AuthRegisterState) {
            Navigator.of(context).pushNamed('/register');
          }
        },
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  welcome + " " + to + " " + appName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: size.height * 0.05),
                Image.asset(
                  "assets/images/welcome.png",
                  height: size.height * 0.45,
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: connexion,
                  press: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogin());
                  },
                ),
                RoundedButton(
                  text: createAccount,
                  color: primaryColor,
                  textColor: Colors.black,
                  press: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthRegister());
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
