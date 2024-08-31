import 'dart:convert';

import 'package:product_catalog_app/utils/string_const.dart';

class ProductModel {
  int? id;
  String name;
  String description;
  List<String> images;
  double price;
  double ratings;
  String category;
  String createdAt;
  String updatedAt;

  ProductModel(
      {this.id,
      required this.name,
      required this.description,
      required this.images,
      required this.price,
      required this.category,
      required this.createdAt,
      required this.ratings,
      required this.updatedAt});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    String id = AppStringConst.productId;
    String name = AppStringConst.productName;
    String description = AppStringConst.productDescription;
    String images = AppStringConst.productImages;
    String price = AppStringConst.productPrice;
    String category = AppStringConst.productCategory;
    String createdAt = AppStringConst.createdAt;
    String updatedAt = AppStringConst.updatedAt;
    String ratings = AppStringConst.rating;
    return ProductModel(
      id: map[id],
        name: map[name],
        description: map[description],
        images: List<String>.from(jsonDecode(map[images])),
        price: map[price],
        ratings: map[ratings],
        category: map[category],
        createdAt: map[createdAt],
        updatedAt: map[updatedAt]);
  }

  Map<String, dynamic> toMap(){
  return {
    AppStringConst.productId:id,
    AppStringConst.productName: name,
    AppStringConst.productDescription:description,
    AppStringConst.productImages:jsonEncode(images),
    AppStringConst.productPrice:price,
    AppStringConst.productCategory:category,
    AppStringConst.createdAt: createdAt,
     AppStringConst.updatedAt:updatedAt,
     AppStringConst.rating: ratings
  };
}

}

