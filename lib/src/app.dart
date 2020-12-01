import 'package:flutter/material.dart';
import 'package:myevent/src/utils/colors.dart';

import 'di/di.dart';

class MyApp extends StatelessWidget {
  /* final UserRepository userRepository;

  MyApp({this.userRepository});*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cursorColor: primaryColor,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.grey[300],
          unselectedLabelColor: whiteColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:
          Container() /* BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return SplashScreen();
          }
          if (state is AuthFirstOpen) {
            return LadingPage();
          }
          if (state is AuthFailure) {
            return BlocProvider(
              create: (context) => getIt<LoginBloc>(),
              child: LoginScreen(
                userRepository: getIt<UserRepository>(),
              ),
            );
          }
          if (state is AuthSuccess) {
            return BlocProvider(
              create: (context) => getIt<TabBloc>(),
              child: HomePage(),
            );
          }
          return SplashScreen();
        },
      )*/
      ,
    );
  }
}
