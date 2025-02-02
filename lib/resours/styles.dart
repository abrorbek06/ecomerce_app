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
}
