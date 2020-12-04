import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/views/login/loginScreen.dart';
import 'package:myevent/src/views/register/components/background.dart';
import 'package:myevent/src/widgets/RoundedInputCPasswordField.dart';
import 'package:myevent/src/widgets/RoundedInputEmailField.dart';
import 'package:myevent/src/widgets/RoundedInputPasswordField.dart';
import 'package:myevent/src/widgets/alreadyHaveAccount.dart';
import 'package:myevent/src/widgets/roundedButton.dart';
import 'package:myevent/src/widgets/roundedInputNameField.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _cpasswordController.addListener(_onCPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(registering),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(registerFailed),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Background(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  createAccount,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.35,
                ),
                RoundedInputNameField(
                  hintText: username,
                  controller: _nameController,
                  icon: Icons.person,
                  registerState: state,
                ),
                RoundedInputEmailField(
                  hintText: email,
                  controller: _emailController,
                  icon: Icons.email,
                  registerState: state,
                ),
                RoundedInputPasswordField(
                  controller: _passwordController,
                  registerState: state,
                ),
                RoundedCPasswordField(
                  controller: _cpasswordController,
                  registerState: state,
                ),
                RoundedButton(
                  text: createAccount,
                  press: _onFormSubmitted,
                  enable: isRegisterButtonEnabled(state),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => getIt<RegisterBloc>(),
                            child: LoginScreen(
                              userRepository: getIt<UserRepository>(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
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

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onCPasswordChanged() {
    _registerBloc.add(
      RegisterCPasswordChanged(
          password: _passwordController.text,
          cpassword: _cpasswordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      ),
    );
  }
}
