import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/utils/app_colors.dart';
import 'package:product_catalog_app/utils/input_formatter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.labeltext,
      required this.descriptionText,
      this.haslabelText = true,
      this.controller,
      this.readOnly = false,
      this.keyboardType,
      this.prefixText,
      this.onchanged,
      this.hasFormatter = true});
  final String? labeltext;
  final String descriptionText;
  final bool haslabelText;
  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Function(String value)? onchanged;
  final bool hasFormatter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: haslabelText ? 15.h : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          haslabelText
              ? CustomText(
                  text: labeltext!,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              : SizedBox(
                  height: 0.h,
                ),
          haslabelText
              ? SizedBox(
                  height: 5.h,
                )
              : SizedBox(
                  height: 0.h,
                ),
          TextFormField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType,
            onChanged: onchanged,
            inputFormatters:
                hasFormatter ? [CapitalizedFirstLetterFormatter()] : null,
            cursorColor: AppColors.black,
            decoration: InputDecoration(
              hintText: descriptionText,
              prefixText: prefixText,
              prefixStyle: TextStyle(color: AppColors.black, fontSize: 16.sp),
              hintStyle: const TextStyle(color: AppColors.grey90, fontSize: 13),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey300,
                  ),
                  borderRadius: BorderRadius.circular(10.sp)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey300,
                  ),
                  borderRadius: BorderRadius.circular(10.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
