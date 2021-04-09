import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/bloc/tab/tab_bloc.dart';
import 'package:myevent/src/di/di.dart';
import 'package:myevent/src/splash.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/views/auth/authScreen.dart';
import 'package:myevent/src/views/home/home.dart';
import 'package:myevent/src/views/lading/ladingPage.dart';
import 'package:myevent/src/views/login/loginScreen.dart';
import 'package:myevent/src/views/register/registerScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/auth': (context) => AuthScreen(),
      },
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
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
            return BlocProvider<AuthBloc>(
              create: (context) => getIt<AuthBloc>(),
              child: AuthScreen(),
            );

            // return AuthScreen();
          }
          if (state is AuthSuccess) {
            return BlocProvider(
              create: (context) => getIt<TabBloc>(),
              child: HomePage(),
            );
          }

          return SplashScreen();
        },
      ),
    );
  }
}
