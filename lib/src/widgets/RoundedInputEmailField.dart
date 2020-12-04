import 'package:flutter/material.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/widgets/textFieldContainer.dart';

class RoundedInputEmailField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final RegisterState registerState;
  const RoundedInputEmailField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.registerState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (_) {
          return !registerState.isEmailValid ? invalidMail : null;
        },
        onChanged: onChanged,
        cursorColor: primaryColor,
        style: TextStyle(fontSize: 15.0, fontFamily: REGULAR),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
