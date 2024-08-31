import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_catalog_app/data/models/product_model.dart';
import 'package:product_catalog_app/data/services/product_service.dart';

class ProductController extends GetxController {
  ProductService productService;
  ProductController({required this.productService});

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  //observable boolean to monitor the state while getting products
  bool gettingProducts = false;

  //observable boolean to monitor the state while deleteing a product
  RxBool deletingProduct = false.obs;

  //observable boolean to monitor the state while updating a product
  RxBool updatingProduct = false.obs;

  //observable boolean to monitor the state while updating a product
  RxBool insertingProduct = false.obs;

  RxList<String> imagePathList = <String>[].obs;
  RxList<String> editImagePathList = <String>[].obs;

  // observable list of product for storing all gotten products
  RxList<ProductModel> productList = <ProductModel>[].obs;

  List<String> categoryTypeList = ['Chairs', 'Tables', 'Sofas', 'Beds'];

  RxString categoryType = 'Choose'.obs;
  RxString editCategoryType = 'Choose'.obs;

  RxInt sliderIndex = 0.obs;
  final productSliderController = PageController();

  changeSliderIndex(int index){
    sliderIndex.value = index;
  }

  // Editing controllers for adding product
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productRatingController = TextEditingController();

  // Editing controllers for editing product
  final editProductNameController = TextEditingController();
  final editProductDescriptionController = TextEditingController();
  final editProductPriceController = TextEditingController();
  final editProductRatingController = TextEditingController();

  // clear all editing controllers
  clearAllTextField() {
    productDescriptionController.clear();
    productNameController.clear();
    productPriceController.clear();
    productRatingController.clear();
  }

  clearAllEditProductValue() {
    editImagePathList.value = [];
    editProductDescriptionController.clear();
    editProductNameController.clear();
    editProductPriceController.clear();
    editProductRatingController.clear();
  }

  initializeEditProductValues(ProductModel product) {
    editProductNameController.text = product.name;
    editProductDescriptionController.text = product.description;
    editProductPriceController.text = '\$${product.price}';
    editCategoryType.value = product.category;
    editImagePathList.value = product.images;
    editProductRatingController.text = product.ratings.toString();
  }

  // insert or add a product by communicating with the product service
  Future<int> insertProduct(ProductModel product) async {
    insertingProduct.value = true;
    await delay();
    int insertedRow = await productService.insertProduct(product);
    if (insertedRow == 0) {
      insertingProduct.value = false;
      return 0;
    } else {
      clearAllTextField();
      imagePathList.value = [];
      insertingProduct.value = false;
      return insertedRow;
    }
  }

  // get all the products by communicating with the product service
  Future<void> getAllProducts() async {
    gettingProducts = true;
    update();
    await delay();
    List<ProductModel> products = await productService.getAllProducts();

    productList.value = [];
    productList.addAll(products);
    gettingProducts = false;
    update();
  }

  // get products based on the category name by communicating with the product service
  Future<void> getCategoryProducts(String categoryName) async {
    gettingProducts = true;
    // adding of delay to make it look like a real time so as to be able to display loaing indicator
    await delay();

    List<ProductModel> products =
        await productService.getCategoryProducts(categoryName);
    productList.value = [];
    productList.addAll(products);
    gettingProducts = false;
    update();
  }

  // get products based on the product name name by communicating with the product service
  Future<void> getProductsByName(String productName) async {
    gettingProducts = true;
    update();
    // adding of delay to make it look like a real time so as to be able to display loaing indicator
    await delay();

    List<ProductModel> products =
        await productService.getProductsByName(productName);
    productList.value = [];
    productList.addAll(products);
    gettingProducts = false;
    update();
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  // get products based on the category name by communicating with the product service
  Future<void> getProductsByPrice(double startPrice, double endPrice) async {
    gettingProducts = true;
    update();

    // adding of delay to make it look like a real time so as to be able to display loaing indicator
    await delay();
    List<ProductModel> products =
        await productService.getProductsByPrice(startPrice, endPrice);
    productList.value = [];
    productList.addAll(products);
    gettingProducts = false;
    update();
  }

  // update a single product by communicating with thr product service
  Future<int> deleteProduct(int productId) async {
    deletingProduct.value == true;
    int deletedRow = await productService.deleteProduct(productId);
    if (deletedRow == 0) {
      deletingProduct.value = false;
      return 0;
    } else {
      deletingProduct.value = false;
      return deletedRow;
    }
  }

  // delete a single product by communicating with thr product service
  Future<int> updateProduct(ProductModel product) async {
    updatingProduct.value = true;
    // adding of delay to make it look like a real time so as to be able to display loaing indicator
    await delay();
    int updatedRow = await productService.updateProduct(product);
    if (updatedRow == 0) {
      updatingProduct.value = false;
      return 0;
    } else {
      clearAllEditProductValue();
      updatingProduct.value = false;
      return updatedRow;
    }
  }

  Future<void> pickImage({bool fromEdit = false}) async {
    final imagePicker = ImagePicker();
    List<XFile> pickedImages = await imagePicker.pickMultiImage();
    final fileList = pickedImages.map((e) => File(e.path)).toList();

    final imgPathList = fileList.map((e) => e.path);
    fromEdit == true
        ? editImagePathList.addAll(imgPathList)
        : imagePathList.addAll(imgPathList);
  }

  bool get validateEditingControllers {
    if (productNameController.text.isEmpty ||
        productDescriptionController.text.isEmpty ||
        productPriceController.text.isEmpty || productRatingController.text.isEmpty) {
      return false;
    }
    return true;
  }

  bool get validateEditProductControllers {
    if (editProductNameController.text.isEmpty ||
        editProductDescriptionController.text.isEmpty ||
        editProductPriceController.text.isEmpty || editProductRatingController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
