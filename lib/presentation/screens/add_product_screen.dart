import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';
import 'package:product_catalog_app/data/models/product_model.dart';
import 'package:product_catalog_app/presentation/screens/home_screen.dart';
import 'package:product_catalog_app/presentation/widgets/custom_button.dart';
import 'package:product_catalog_app/presentation/widgets/custom_dialog.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text_field.dart';
import 'package:product_catalog_app/presentation/widgets/snackbar.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

class AddProductScreen extends GetView<ProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Add Product',
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () => controller.pickImage(),
                    icon: Icon(
                      Icons.image,
                      size: 200.sp,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.h),
                child: const CustomText(
                  text: 'Click the image icon for uploading the product photos',
                  fontSize: 14,
                ),
              ),
              controller.imagePathList.isEmpty
                  ? SizedBox(
                      height: 0.h,
                      width: 0.w,
                    )
                  : SizedBox(
                      height: 70.h,
                      child: Obx(
                        () => ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imagePathList.length,
                            itemBuilder: (context, index) => Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: GestureDetector(
                                      onTap: () => controller.imagePathList
                                          .removeAt(index),
                                      child: Badge(
                                        backgroundColor: AppColors.black,
                                        label: Icon(
                                          Icons.cancel,
                                          size: 10.sp,
                                          color: AppColors.white,
                                        ),
                                        child: Image.file(
                                          File(controller.imagePathList[index]),
                                          height: 70.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      labeltext: 'Name',
                      descriptionText: 'Enter your product name',
                      controller: controller.productNameController,
                    ),
                    CustomTextField(
                      labeltext: 'Description',
                      descriptionText: 'Enter your product description',
                      controller: controller.productDescriptionController,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 160.w,
                              child: CustomTextField(
                                labeltext: 'Price',
                                descriptionText: '',
                                prefixText: '\$',
                                controller: controller.productPriceController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: 'Category',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.grey300,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  child: GestureDetector(
                                    onTap: () => Get.focusScope?.unfocus(),
                                    child: CustomDropdown<String>(
                                      hintText: controller.categoryType.value,
                                      items: controller.categoryTypeList,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.categoryType.value = value;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 160.w,
                        child: CustomTextField(
                          labeltext: 'Ratings',
                          descriptionText: '',
                          controller: controller.productRatingController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
                  child: customButton(
                      width: double.maxFinite,
                      widget: controller.insertingProduct.value == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : const CustomText(
                              text: 'Add',
                              textColor: AppColors.white,
                            ),
                      onPressed: () {
                        if (!controller.validateEditingControllers) {
                          errorSnackbar(
                              title: 'Caution',
                              message: "Please, fill in the required fleld");
                        } else if (controller.imagePathList.isEmpty) {
                          errorSnackbar(
                              title: 'Caution',
                              message:
                                  "You must pick at least one product image");
                        } else if (controller.categoryType.value == 'Choose') {
                          errorSnackbar(
                              title: 'Caution',
                              message:
                                  "You must select a category for the product");
                        } else if (double.parse(
                                controller.productRatingController.text) >
                            5.0) {
                          errorSnackbar(
                              title: 'Caution',
                              message: "Please enter a valid rating");
                        } else {
                          final productInfo = ProductModel(
                              name: controller.productNameController.text,
                              description:
                                  controller.productDescriptionController.text,
                              images: controller.imagePathList,
                              price: double.parse(
                                  controller.productPriceController.text),
                              ratings: double.parse(
                                  controller.productRatingController.text),
                              category: controller.categoryType.value,
                              createdAt: DateTime.now().toIso8601String(),
                              updatedAt: DateTime.now().toIso8601String());

                          controller.insertProduct(productInfo).then((value) {
                            if (value == 0) {
                              errorSnackbar(
                                  title: 'Failed',
                                  message:
                                      "Failed to add the product, please try again");
                            } else {
                              showDialog(
                                builder: (context) => customDialog(
                                    context: context,
                                    hasSingleButton: true,
                                    descriptionText:
                                        'Successfully added the product to the product list',
                                    onPressed: () {
                                      Get.delete<ProductController>(
                                          force: true);
                                      Get.delete<HomeController>(force: true);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (Route<dynamic> route) => false);
                                    }),
                                context: context,
                              );
                            }
                          });
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
