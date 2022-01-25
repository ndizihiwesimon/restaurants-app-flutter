import 'package:flutter/material.dart';
import 'package:mad_final_project/components/auth/textfield_container.dart';
import 'package:mad_final_project/themes/colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.controller, this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      controller: controller,
      validator: validator,
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        icon: Icon(
          Icons.lock,
          color: primaryTextColor,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: primaryTextColor,
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
