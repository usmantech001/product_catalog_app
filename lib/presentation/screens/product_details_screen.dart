import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';
import 'package:product_catalog_app/data/models/product_model.dart';
import 'package:product_catalog_app/presentation/screens/edit_product_screen.dart';
import 'package:product_catalog_app/presentation/widgets/custom_button.dart';
import 'package:product_catalog_app/presentation/widgets/custom_icon.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends GetView<ProductController> {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp)),
        child: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "\$${product.price}",
                textColor: AppColors.deepGreen,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              customButton(
                  widget: const CustomText(
                    text: 'Edit',
                    textColor: AppColors.white,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen(product: product))),
                              )
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customIcon(
                  icon: Icons.navigate_before,
                  onTap: () => Navigator.pop(context),
                ),
                customIcon(
                  icon: Icons.edit,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen(product: product))),
                )
              ],
            ),
            expandedHeight: 360.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 340.h,
                        width: double.maxFinite,
                        child: PageView.builder(
                          controller: controller.productSliderController,
                          scrollDirection: Axis.horizontal,
                          itemCount: product.images.length,
                          onPageChanged: (value) =>
                              controller.changeSliderIndex(value),
                          itemBuilder: (context, index) => Image.file(
                              fit: BoxFit.cover, File(product.images[index])),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      product.images.length == 1
                          ? const SizedBox()
                          : Obx(
                              () => AnimatedSmoothIndicator(
                                activeIndex: controller.sliderIndex.value,
                                count: product.images.length,
                                effect: ExpandingDotsEffect(
                                    spacing: 8.0,
                                    radius: 8.0.sp,
                                    dotWidth: 10.0.w,
                                    dotHeight: 8.0.h,
                                    // paintStyle: PaintingStyle.stroke,
                                    // strokeWidth: 1.5,
                                    dotColor: Colors.grey.withOpacity(0.4),
                                    activeDotColor: AppColors.black),
                              ),
                            ),
                    ],
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: product.name,
                    textColor: AppColors.black24,
                    fontSize: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.starColor,
                          size: 25.sp,
                        ),
                        CustomText(
                          text: product.ratings.toString(),
                          textColor: AppColors.black08,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                  CustomText(
                    text: product.description,
                    fontSize: 14.sp,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
