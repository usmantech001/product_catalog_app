import 'package:get/get.dart';
import 'package:product_catalog_app/data/controllers/home_controller.dart';
import 'package:product_catalog_app/data/controllers/product_controller.dart';
import 'package:product_catalog_app/data/db_helper/db_helper.dart';
import 'package:product_catalog_app/data/services/product_service.dart';

Future<void> init() async{
 // await DBHelper().deleteDatabase1();
  final db =await DBHelper().initDatabase();
  //injection of the services
  Get.lazyPut(()=> ProductService(db));
  //injection of the controllers
  Get.lazyPut(()=>HomeController(productController: Get.find()), fenix: true);
  Get.lazyPut(()=> ProductController(productService: Get.find()), fenix: true);

  
}