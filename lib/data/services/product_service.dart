import 'package:get/get.dart';
import 'package:product_catalog_app/data/models/product_model.dart';
import 'package:product_catalog_app/utils/string_const.dart';
import 'package:sqflite/sqflite.dart';

class ProductService extends GetxService{
  Database db;
  ProductService(this.db);

 String tableName = AppStringConst.tableName;
 String id = AppStringConst.productId;
 String category = AppStringConst.productCategory;
 String price = AppStringConst.productPrice;
 String name = AppStringConst.productName;
 String updatedAt = AppStringConst.updatedAt;
 
 // insert of products to the local database
  Future<int> insertProduct(ProductModel product) async{
    try{
     return await db.insert(tableName, product.toMap());
    }catch (e){
     return 0;
    }
   
  }

 // getting all the products 
  Future<List<ProductModel>> getAllProducts() async{
   List<Map<String, dynamic>> products = await db.query(tableName, orderBy: "$updatedAt DESC");
   return products.map((map)=> ProductModel.fromMap(map)).toList();
  }


  // getting products based on category
  Future<List<ProductModel>> getCategoryProducts(String categoryName) async{
   List<Map<String, dynamic>> products = await db.query(tableName, where: '$category = ?', whereArgs: [categoryName]);
   return products.map((map)=> ProductModel.fromMap(map)).toList();
  }

  
  // getting products based on category
  Future<List<ProductModel>> getProductsByName(String productName) async{
   List<Map<String, dynamic>> products = await db.query(tableName, where: '$name LIKE ?', whereArgs: ['%$productName%']);
   return products.map((map)=> ProductModel.fromMap(map)).toList();
  }

  // getting products based on price
  Future<List<ProductModel>> getProductsByPrice(double startPrice, double endPrice) async{
   List<Map<String, dynamic>> products = await db.query(tableName, where: '$price >= ? AND $price <= ?', whereArgs: [startPrice, endPrice]);
   return products.map((map)=> ProductModel.fromMap(map)).toList();
  }
  // delete a particular product
Future<int> deleteProduct(int productId) async{
  try{
    return await db.delete(tableName, where: '$id = ?', whereArgs: [productId]);
  }catch (e){
   return 0;
  }
}

 // update a particular product
Future<int> updateProduct(ProductModel product) async{
  try{
    return await db.update(tableName, product.toMap(), where: '$id = ?', whereArgs: [product.id]);
  }catch (e){
   
   return 0;
  }
}
}

