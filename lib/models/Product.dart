import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Product {
  final String productName;
  final String image;
  final int price;
  final String description;

  Product({
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.productName
  });


static  List<Product> cartList = List<Product>();

  static var CartNumber=0.obs;
static var total=0;



}