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

class EditProductScreen extends GetView<ProductController> {
  const EditProductScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    controller.initializeEditProductValues(product);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Edit Product',
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
                    onPressed: () => controller.pickImage(fromEdit: true),
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
              controller.editImagePathList.isEmpty
                  ? SizedBox(
                      height: 0.h,
                      width: 0.w,
                    )
                  : SizedBox(
                      height: 70.h,
                      child: Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.editImagePathList.length,
                            itemBuilder: (context, index) => Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: GestureDetector(
                                      onTap: () => controller.editImagePathList
                                          .removeAt(index),
                                      child: Badge(
                                        backgroundColor: AppColors.black,
                                        label: Icon(
                                          Icons.cancel,
                                          size: 10.sp,
                                          color: AppColors.white,
                                        ),
                                        child: Image.file(
                                          File(controller
                                              .editImagePathList[index]),
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
                      descriptionText:
                          controller.editProductNameController.text,
                      controller: controller.editProductNameController,
                    ),
                    CustomTextField(
                      labeltext: 'Description',
                      descriptionText:
                          controller.editProductDescriptionController.text,
                      controller: controller.editProductDescriptionController,
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
                                descriptionText:
                                    '\$${controller.editProductPriceController.text}',
                                controller:
                                    controller.editProductPriceController,
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
                                      // hintText: controller.editCategoryType.value,
                                      items: controller.categoryTypeList,
                                      initialItem: product.category,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.editCategoryType.value =
                                              value;
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
                          controller: controller.editProductRatingController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: customButton(
                      widget: controller.updatingProduct.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : const CustomText(
                              text: 'Edit',
                              textColor: AppColors.white,
                            ),
                      width: double.maxFinite,
                      onPressed: () {
                        if (!controller.validateEditProductControllers) {
                          errorSnackbar(
                              title: 'Caution',
                              message: "Please, fill in the required fleld");
                        } else if (controller.editImagePathList.isEmpty) {
                          errorSnackbar(
                              title: 'Caution',
                              message:
                                  "You must pick at least one product image");
                        } else if (controller.editCategoryType.value ==
                            'Choose') {
                          errorSnackbar(
                              title: 'Caution',
                              message:
                                  "You must select a category for the product");
                        } else if (double.parse(
                                controller.editProductRatingController.text) >
                            5.0) {
                          errorSnackbar(
                              title: 'Caution',
                              message: "Please enter a valid rating");
                        } else {
                          final price = controller
                              .editProductPriceController.text
                              .replaceAll('\$', '');

                          final productInfo = ProductModel(
                              id: product.id,
                              name: controller.editProductNameController.text,
                              description: controller
                                  .editProductDescriptionController.text,
                              images: controller.editImagePathList,
                              price: double.parse(price),
                              ratings: double.parse(
                                  controller.editProductRatingController.text),
                              category: controller.editCategoryType.value,
                              createdAt: product.createdAt,
                              updatedAt: DateTime.now().toIso8601String());

                          controller.updateProduct(productInfo).then((value) {
                            if (value == 0) {
                              errorSnackbar(
                                  title: 'Failed',
                                  message:
                                      "Failed to edit the product, please try again");
                            } else {
                              showDialog(
                                builder: (context) => customDialog(
                                    hasSingleButton: true,
                                    context: context,
                                    descriptionText:
                                        'Successfully edited the product ',
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
