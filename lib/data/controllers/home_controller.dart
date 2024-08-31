import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';

class HomeController extends GetxController {
  ProductController productController;
  HomeController({required this.productController});

   final List<String> imgPath = ["star", "chair", "table", "sofa", "bed"];
    final List<String> categoryName = [
      "All",
      "Chairs",
      "Tables",
      "Sofas",
      "Beds"
    ];

  // index controlling the category tab
  RxInt tabIndex = 0.obs;
  //This is a controller for managing the page view
  final pageController = PageController();

  //slider range values
  RxDouble start = 100.0.obs;
  RxDouble end = 1000.0.obs;

  changeSliderValues(RangeValues values) {
    start.value = values.start;
  end.value = values.end;
  }
  // This is called when the tab is click to change the index and the page view
  changeTabIndex(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 30), curve: Curves.easeIn);
    tabIndex.value = index;
  }

  
}
