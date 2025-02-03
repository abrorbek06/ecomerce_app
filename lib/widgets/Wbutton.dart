import 'package:flutter/material.dart';

import '../resours/colors.dart';
import '../resours/styles.dart';
import '../screens/login_screen.dart';

class Wbutton extends StatefulWidget {
  final String text;
  final Widget screen;
  const Wbutton({super.key, required this.text, required this.screen});

  @override
  State<Wbutton> createState() => _WbuttonState();
}

class _WbuttonState extends State<Wbutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget.screen));
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(56)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: AppStyles.enterScreenText,
            ),
          ],
        ),
      ),
    );
  }
}
