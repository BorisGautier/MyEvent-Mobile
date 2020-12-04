import 'package:flutter/material.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/widgets/textFieldContainer.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final LoginState loginState;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.loginState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        autocorrect: false,
        validator: (_) {
          return !loginState.isPasswordValid ? invalidPass : null;
        },
        style: TextStyle(fontSize: 15.0, fontFamily: REGULAR),
        obscureText: true,
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: password,
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
