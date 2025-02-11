import 'package:ecomerce_app/resours/colors.dart';
import 'package:flutter/cupertino.dart';

abstract class AppStyles {
  static const titleStyle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  );
  static const enterScreenText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const LoginTitleText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  );
  static const LoginTDescriptionText = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static const description = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static const author = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const nameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.descriptionColor,
  );
}
