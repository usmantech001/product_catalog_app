import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';
import 'package:product_catalog_app/presentation/screens/add_product_screen.dart';
import 'package:product_catalog_app/presentation/widgets/bottom_sheet.dart';
import 'package:product_catalog_app/presentation/widgets/custom_grid_view.dart';
import 'package:product_catalog_app/presentation/widgets/custom_tab_bar.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text.dart';
import 'package:product_catalog_app/presentation/widgets/custom_text_field.dart';
import 'package:product_catalog_app/presentation/widgets/shimer.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.tabIndex.value = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.focusScope?.unfocus();
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()));
        },
        backgroundColor: AppColors.black30,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h),
              child: SizedBox(
                width: 230.w,
                child: const CustomText(
                  text: 'Find modern furniture for you',
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black30,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Expanded(
                      child: CustomTextField(
                    descriptionText: "Search for furniture",
                    haslabelText: false,
                    onchanged: (productName) =>controller.productController.getProductsByName(productName) ,
                  )),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      builder: (context) => bottomSheet(controller: controller),
                      context: context,
                    ),
                    child: Container(
                      // height: 50.h,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Image.asset(
                        "assets/images/filter.png",
                        height: 30.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      controller.changeTabIndex(index);
                      index == 0
                          ? controller.productController.getAllProducts()
                          : controller.productController.getCategoryProducts(
                              controller.categoryName[index]);
                    },
                    child: CustomTabBar(index: index, controller: controller)),
              ),
            ),
            GetBuilder<ProductController>(builder: (productController) {
              return Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    controller: controller.pageController,
                    itemBuilder: (context, index) =>
                        productController.gettingProducts == true
                            ? gridShimmer(context)
                            : productController.gettingProducts == false &&
                                    productController.productList.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: const CustomText(
                                        text:
                                            'No product found, please add products',
                                      ),
                                    ),
                                  )
                                : CustomGridView(
                                    productController: productController,
                                  )),
              );
            })
          ],
        ),
      ),
    );
  }
}
