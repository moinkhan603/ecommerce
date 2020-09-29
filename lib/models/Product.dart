
import 'package:get/get.dart';
class Product {
  final String productName;
  final String image;
  final int price;
  final String description;
 int qty;
  Product({
     this.description,
     this.image,
     this.price,
     this.productName,
    this.qty
  });



 AddQTY()
{
  qty=qty+1;
}

static  List<Product> cartList = List<Product>();

  static var CartNumber=0.obs;
static var total=0;



}