import 'package:ecomerce_app/resours/colors.dart';
import 'package:ecomerce_app/resours/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../resours/assets.dart';

class Webviewscreen extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String author;
  final String name;
  const Webviewscreen({super.key, required this.title,
    required this.image,
    required this.description,
    required this.author,
    required this.name
      });

  @override
  State<Webviewscreen> createState() => _WebviewscreenState();
}

class _WebviewscreenState extends State<Webviewscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 183,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: widget.image != null
                          ? NetworkImage(widget.image)
                          : AssetImage(Assets.logoSVG),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.author, style: AppStyles.author,),
                const SizedBox(height: 6),
                Text(widget.title, style: AppStyles.nameStyle.copyWith(color: AppColors.black)),
                const SizedBox(height: 10),
                Text(widget.description, style: AppStyles.description. copyWith(fontWeight: FontWeight.w400),),
                const SizedBox(height: 10),
                Text(widget.name, style: AppStyles.nameStyle,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
