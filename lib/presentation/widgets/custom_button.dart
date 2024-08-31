import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

Widget customButton(
    {
    required VoidCallback onPressed,
    required Widget widget,
    Color bgColor = AppColors.primary,
    double width = 140}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          fixedSize: Size(width.w, 45.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          )),
      child: widget);
}
