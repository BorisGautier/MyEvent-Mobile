import 'package:flutter/material.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/widgets/textFieldContainer.dart';

class RoundedPasswordField extends StatefulWidget {
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
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.always,
        autocorrect: false,
        validator: (_) {
          return !widget.loginState.isPasswordValid ? invalidPass : null;
        },
        style: TextStyle(fontSize: 15.0, fontFamily: REGULAR),
        obscureText: obscureText,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: password,
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            color: primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
