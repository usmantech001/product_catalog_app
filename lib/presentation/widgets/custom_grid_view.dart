import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';
import 'package:product_catalog_app/presentation/screens/product_details_screen.dart';
import 'package:product_catalog_app/presentation/widgets/custom_dialog.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';

import '../../utils/app_colors.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView(
      {super.key, required this.productController});

  final ProductController productController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ColoredBox(
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: GridView.builder(
            padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisExtent: 220.h,
                mainAxisSpacing: 15.h),
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              final product = productController.productList[index];
              return GestureDetector(
                onTap: (){
                  Get.focusScope?.unfocus();
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ProductDetailsScreen(product: product,)));
                },
                child: 
                    Container(
                      height: 200.h,
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, bottom: 5.w),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.sp),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.w, 0.h),
                                spreadRadius: 0.3,
                                color: AppColors.grey90.withOpacity(0.5)),
                            BoxShadow(
                                offset: Offset(-0.w, 0.h),
                                color: AppColors.grey90.withOpacity(0.3))
                          ]),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Image.file(
                             File(
                               product.images[0],
                             ),
                             //height: 130.h,
                             width: 160.w,
                             fit: BoxFit.cover,
                           ),
                           const Expanded(child: SizedBox()),
                          CustomText(
                            text: product.name,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            textColor: AppColors.black24,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: '\$${product.price}',
                                fontSize: 14,
                                textColor: AppColors.deepGreen,
                                fontWeight: FontWeight.w500,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.focusScope?.unfocus();
                                     showDialog(
                                        builder: (context) => customDialog(
                                          context: context,
                                          descriptionText:
                                              'Are you sure you want to delete this product?',
                                          onPressed: () {
                                            productController
                                              .deleteProduct(productController
                                                  .productList[index].id!);
                                                  Navigator.pop(context);
                                                  productController.getAllProducts();
                                          }
                                        ),
                                        context: context,
                                      );
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                   

                        
                 
              );
            }),
      ),
    );
  }
}
