import 'package:flutter/material.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/themes/colors.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Color bcolor;
  String? text = "Hi";
  IconData? icon;
  double size;
  final Color borderColor;
  bool? isIcon;

  AppButton(
      {Key? key,
      this.isIcon = false,
      this.text,
      this.icon,
      required this.size,
      required this.color,
      required this.bcolor,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color: bcolor),
      child: isIcon == false
          ? MySmallText(
              text: text!,
              color: primaryTextColor,
            )
          : Icon(icon, color: color),
    );
  }
}
