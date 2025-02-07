import 'package:ecomerce_app/resours/styles.dart';
import 'package:ecomerce_app/widgets/Wbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resours/assets.dart';
import '../resours/colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.bg_singin_screen), fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("English", style: AppStyles.enterScreenText,),
                  const SizedBox(width: 10),
                  SvgPicture.asset(Assets.arrow_down)
                ],
              ),
              const SizedBox(height: 100),
              Container(
                width: double.infinity,
                height: 610,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 36),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _TitleText("Let's", AppColors.textColor),
                          _TitleText("Travel", AppColors.mainColor),
                          _TitleText("you", AppColors.textColor),
                          _TitleText("in.", AppColors.mainColor),
                        ],
                      ),
                      const Text("Discover the World with Every Sign In", style: AppStyles.LoginTDescriptionText,),
                      const SizedBox(height: 34),
                      _TextFeild('Email or Phone Number'),
                      _TextFeild('Password'),
                      const Align(alignment: Alignment(1, 0) ,child: Text("Forgot password?", style: AppStyles.description,),),
                      const SizedBox(height: 33),
                      const Wbutton(text: "Sign In", screen: LoginScreen()),
                      const SizedBox(height: 20),
                      const Text("or sign in with", style: AppStyles.description,),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _SocailMedia(Assets.googleLogo),
                          _SocailMedia(Assets.appleLogo),
                          _SocailMedia(Assets.facebookLogo),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Text('I don’t have a account?', style: AppStyles.description,)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Center(child: Text("Sing Up", style: AppStyles.LoginTitleText.copyWith(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _TitleText(text, color) => Text("$text ", style: AppStyles.LoginTitleText.copyWith(color: color),);
  _TextFeild(text) => Padding(
    padding: const EdgeInsets.only(bottom: 19),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: text,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.secondryColor
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.6,
              color: AppColors.textColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.textColor
          ),
        ),
      ),
    ),
  );
  _SocailMedia(String icon) => Container(
    width: 75,
    height: 55,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: AppColors.shadowColor,
          spreadRadius: -5,
          blurRadius: 10,
          offset: Offset(0, 0),
        ),
      ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(icon),
    ),
  );
}