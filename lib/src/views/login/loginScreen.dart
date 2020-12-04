import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/views/login/login.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  LoginScreen({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => getIt<LoginBloc>(),
        child: Login(),
      ),
    );
  }
}
