import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

Widget priceRangeBox(HomeController controller, double value, String text) {
  return Column(
    children: [
       CustomText(
        text: text,
        fontWeight: FontWeight.w500,
      ),
      Container(
          margin: EdgeInsets.only(top: 5.h),
          width: 100.w,
          height: 70.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp), border:Border.all(color: AppColors.grey300) ),
          child: CustomText(
            text: value.toStringAsFixed(2),
            fontWeight: FontWeight.w300,
          )),
    ],
  );
}
