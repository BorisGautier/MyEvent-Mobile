import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/views/register/register.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;

  RegisterScreen({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => getIt<RegisterBloc>(),
        child: Register(),
      ),
    );
  }
}
