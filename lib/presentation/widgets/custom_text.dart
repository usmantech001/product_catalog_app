import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.textColor = AppColors.primary,
      this.overflow,
      this.fontSize = 20,
      this.fontWeight});
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow; 
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize.sp,
        fontWeight: fontWeight
      ),
    );
  }
}
