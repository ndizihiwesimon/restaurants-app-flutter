import 'package:flutter/material.dart';
import 'package:mad_final_project/components/auth/textfield_container.dart';
import 'package:mad_final_project/themes/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintTxt; 
  final IconData ikon;  
  final TextEditingController controller;
  final ValueChanged<String> onChanged; 
  final String? Function(dynamic value)? validator;
  final TextInputType keyboardType;

  const RoundedInputField({
    Key? key, required this.hintTxt, this.ikon=Icons.person, required this.onChanged, required this.controller, this.validator, required this.keyboardType,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        textInputAction: TextInputAction.next,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: Icon(
          ikon,
          color: primaryTextColor,
        ),
        hintText: hintTxt,
        border: InputBorder.none,
        ),
    )
          );
  }
}
