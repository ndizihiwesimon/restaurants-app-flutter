
import 'package:flutter/material.dart';
import 'package:mad_final_project/themes/colors.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: const Color(0xFFF5F6F9),
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: primaryColor
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: Text(text))
          ],
        ),
      ),
    );
  }
}