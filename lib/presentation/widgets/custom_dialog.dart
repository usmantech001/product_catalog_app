import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/presentation/widgets/custom_button.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';

import '../../utils/app_colors.dart';

Widget customDialog({
  required BuildContext context,
  required VoidCallback onPressed,
  bool hasSingleButton = false,
  required String descriptionText,
}) {
  return Dialog(
    insetPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
    ),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12.sp)),
      padding:
          EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w, bottom: 25.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasSingleButton
              ? const Icon(Icons.done_all_outlined)
              : const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: CustomText(text: descriptionText)),
          hasSingleButton
              ? customButton(
                width: double.maxFinite,
                  widget: const CustomText(
                    text: 'Check now',
                    textColor: AppColors.white,
                  ),
                  onPressed: onPressed)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton(
                        widget: const CustomText(
                          text: 'No',
                          textColor: AppColors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                        bgColor: Colors.red),
                    customButton(
                        widget: const CustomText(
                          text: 'Yes',
                          textColor: AppColors.white,
                        ),
                        onPressed: onPressed)
                  ],
                ),
        ],
      ),
    ),
  );
}
