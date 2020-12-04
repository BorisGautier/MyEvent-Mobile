import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/styles.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.all(fixPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/affiche.png',
                width: 200.0,
                fit: BoxFit.fitWidth,
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              SpinKitPulse(
                color: darkPrimaryColor,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
