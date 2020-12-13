import 'package:flutter/material.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/widgets/textFieldContainer.dart';

class RoundedInputPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final RegisterState registerState;
  const RoundedInputPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.registerState,
  }) : super(key: key);

  @override
  _RoundedInputPasswordFieldState createState() =>
      _RoundedInputPasswordFieldState();
}

class _RoundedInputPasswordFieldState extends State<RoundedInputPasswordField> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.always,
        autocorrect: false,
        validator: (_) {
          return !widget.registerState.isPasswordValid ? invalidPass : null;
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
