import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/splash.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/views/auth/auth.dart';
import 'package:myevent/src/views/home/home.dart';
import 'package:myevent/src/views/lading/ladingPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cursorColor: primaryColor,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.grey[300],
          unselectedLabelColor: whiteColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return SplashScreen();
          }
          if (state is AuthFirstOpen) {
            return LadingPage();
          }
          if (state is AuthFailure) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<LoginBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<RegisterBloc>(),
              ),
            ], child: AuthScreen());

            // return AuthScreen();
          }
          if (state is AuthSuccess) {
            /* return BlocProvider(
              create: (context) => getIt<TabBloc>(),
              child: HomePage(),
            );*/

            return Home(name: state.name);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
