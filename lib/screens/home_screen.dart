import 'package:ecomerce_app/resours/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resours/assets.dart';
import '../resours/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bg_home),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi, Paul", style: AppStyles.titleStyle.copyWith(color: AppColors.white),),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.appbar_icon),
                          const SizedBox(width: 8),
                          Text("2.000 points", style: AppStyles.description.copyWith(color: AppColors.goldColor),)
                        ],
                      )
                    ],
                  ),
                  const CircleAvatar(
                    maxRadius: 30,
                    minRadius: 20,
                    foregroundImage: AssetImage(Assets.cat_ava),
                  ),
                ],
              ),
              const SizedBox(height: 17),

            ],
          ),
        ),
      ),
    );
  }
}
