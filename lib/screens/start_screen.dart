import 'package:ecomerce_app/resours/assets.dart';
import 'package:ecomerce_app/resours/styles.dart';
import 'package:ecomerce_app/screens/home_screen.dart';
import 'package:ecomerce_app/screens/login_screen.dart';
import 'package:ecomerce_app/widgets/Wbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resours/colors.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.bg_start_screen), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(Assets.logo),
            const SizedBox(
              height: 340,
            ),
            Container(
              width: double.infinity,
              height: 307,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 41, vertical: 54),
                child: Column(
                  children: [
                    Text(
                      "Ready to explore beyond boundaries?",
                      style: AppStyles.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Wbutton(text: "Your Journey Starts Here", screen: LoginScreen(),),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
