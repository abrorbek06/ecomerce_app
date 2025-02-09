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
                      Text(
                        "Hi, Paul",
                        style: AppStyles.titleStyle
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.appbar_icon),
                          const SizedBox(width: 8),
                          Text(
                            "2.000 points",
                            style: AppStyles.description
                                .copyWith(color: AppColors.goldColor),
                          )
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
              _TextFeild("Where we go?"),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 183,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.gray
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 83,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.textColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                "Upcoming",
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "24 March 2024",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      const SizedBox(width: 14),
                      const Row(
                        children: [
                          Column(
                            children: [],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _TextFeild(text) => Padding(
        padding: const EdgeInsets.only(bottom: 19),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: text,
            prefixIcon: const Icon(Icons.search),
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.secondryColor),
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
              borderSide:
                  const BorderSide(width: 1, color: AppColors.textColor),
            ),
          ),
        ),
      );
}
