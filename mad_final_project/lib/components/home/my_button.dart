import 'package:flutter/material.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/pages/login.dart';
import 'package:mad_final_project/themes/colors.dart';

class MyButton extends StatelessWidget {
  double? width;
  double? height;
  final String text;
  final Function() press;
  final bool short;

  MyButton({Key? key, required this.text, required this.press, this.width, this.height, this.short=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Flexible(
        child: Container(
          width: width,
          height: short?height:60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(short?10:12),
            color: darkColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MySmallText(text: text, color: textWhiteColor, size: 16,),
              SizedBox(width: 20,),
              Icon(Icons.arrow_forward, color: textWhiteColor,)
            ],
          ),
        ),
      ),
    );
  }
}
