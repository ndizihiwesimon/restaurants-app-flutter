
import 'package:flutter/material.dart';
import 'package:mad_final_project/themes/colors.dart';

class MyLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  MyLargeText(
      {Key? key,
      this.size = 30.00,
      required this.text,
      this.color = primaryTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}

class MySmallText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  MySmallText(
      {Key? key,
      this.size = 16.00,
      required this.text,
      this.color = secondaryTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: 1.5,
      ),
    );
  }
}


