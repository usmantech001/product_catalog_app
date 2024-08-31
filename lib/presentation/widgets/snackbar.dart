import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

errorSnackbar({required String title, required String message}) {
  return Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning),
      backgroundColor: AppColors.redColor);
}