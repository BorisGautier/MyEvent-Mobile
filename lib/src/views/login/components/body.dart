import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/views/login/components/background.dart';
import 'package:myevent/src/views/login/components/divider.dart';
import 'package:myevent/src/views/login/components/socialIcon.dart';
import 'package:myevent/src/views/register/registerScreen.dart';
import 'package:myevent/src/widgets/alreadyHaveAccount.dart';
import 'package:myevent/src/widgets/roundedButton.dart';
import 'package:myevent/src/widgets/roundedInputField.dart';
import 'package:myevent/src/widgets/roundedPasswordField.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(loginFailed), Icon(Icons.error)],
                ),
                backgroundColor: red,
                duration: Duration(seconds: 7),
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loggin),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSend) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(emailSend), Icon(Icons.check_circle)],
                ),
                backgroundColor: green,
                duration: Duration(seconds: 7),
              ),
            );
        }
        if (state.isFailSend) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(emailNoSend), Icon(Icons.error)],
                ),
                backgroundColor: red,
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(loginSuccess), Icon(Icons.check_circle)],
                ),
                backgroundColor: green,
                duration: Duration(seconds: 7),
              ),
            );
          BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Background(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "CONNECTEZ VOUS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: email,
                  controller: _emailController,
                  icon: Icons.email,
                  loginState: state,
                ),
                RoundedPasswordField(
                  controller: _passwordController,
                  loginState: state,
                ),
                RoundedButton(
                  text: connexion,
                  press: _onFormSubmitted,
                  enable: isLoginButtonEnabled(state),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () async {
                    _emailController.text.isNotEmpty
                        ? _reset(_emailController.text)
                        : Fluttertoast.showToast(
                            msg: "Remplissez l'adresse mail",
                            backgroundColor: red);
                  },
                  child: Text(
                    forgotPass,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => getIt<RegisterBloc>(),
                            child: RegisterScreen(
                              userRepository: getIt<UserRepository>(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/images/facebook.svg",
                      press: _onFacebookSubmitted,
                      color: Colors.blue[900],
                    ),
                    SocalIcon(
                      iconSrc: "assets/images/twitter.svg",
                      press: _onTwitterSubmitted,
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginEmailChanged() {
    _loginBloc.add(
      LoginEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onFacebookSubmitted() {
    _loginBloc.add(
      LoginWithFacebookPressed(),
    );
  }

  void _onTwitterSubmitted() {
    _loginBloc.add(
      LoginWithTwitterPressed(),
    );
  }

  void _reset(String mail) {
    _loginBloc.add(
      PasswordReset(email: mail),
    );
  }
}
