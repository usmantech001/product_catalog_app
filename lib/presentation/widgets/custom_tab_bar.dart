import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

class CustomTabBar extends StatelessWidget {
   const CustomTabBar({super.key, required this.index, required this.controller});
 final int index;
 final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return  Obx(
                        ()=>Container(
                          margin: EdgeInsets.only(right: 20.w),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                              color: controller.tabIndex.value == index
                                  ? AppColors.black
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/${controller.imgPath[index]}.png",
                                height: 15,
                                color: controller.tabIndex.value == index
                                    ? AppColors.white
                                    : AppColors.grey90,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(
                                () => CustomText(
                                  text: controller.categoryName[index],
                                  textColor: controller.tabIndex.value == index
                                      ? AppColors.white
                                      : AppColors.grey90,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    
  }
}