// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/presentation/widgets/custom_button.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/presentation/widgets/price_range_box.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

Widget bottomSheet({required HomeController controller}) {
  return Obx(
    () => Container(
      height: 350.h,
      padding:
          EdgeInsets.only(top: 30.h, right: 16.w, left: 16.w, bottom: 30.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.sp),
            topRight: Radius.circular(10.sp),
          )),
      child: Column(
        children: [
          CustomText(
            text: "Price Range",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          RangeSlider(
            activeColor: const Color.fromARGB(255, 1, 31, 54),
            inactiveColor: AppColors.grey300,
            min: 100.0,
            max: 1000.0,
            values: RangeValues(controller.start.value, controller.end.value),
            onChanged: (values) => controller.changeSliderValues(values),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              priceRangeBox(controller, controller.start.value, 'Min'),
              SizedBox(
                width: 10.w,
              ),
             priceRangeBox(controller, controller.end.value, 'Max')
            ],
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomRight,
            child: customButton(widget:  const CustomText(
        text: 'Apply',
        textColor: AppColors.white,
      ), onPressed: (){
              Get.back();
              controller.productController.getProductsByPrice(controller.start.value, controller.end.value);
            }),
          )
        ],
      ),
    ),
  );
}
