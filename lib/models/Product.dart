
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class Product {
   String productName;
   String image;
   int price;
   String description;
 int qty;
  Product({
     this.description,
     this.image,
     this.price,
     this.productName,
    this.qty
  });


  Product.fromJson(Map<String, dynamic> json) {
    productName = json['name'];
    image = json['img'];
    price = json['price'];
    description = json['description'];
   qty=0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.productName;
    data['img'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }


 static Future<List<Product>> getAllData() async {
    print(category);
    print("Active Users");
    var val = await Firestore.instance
        .collection(category.value)
        .getDocuments();
    var documents = val.documents;
    print("Documents ${documents.length}");
    if (documents.length > 0) {
      try {

        print(documents[0]['name']);
        print("Active ${documents.length}");
        return documents.map((document) {
          Product allProducts = Product.fromJson(Map<String, dynamic>.from(document.data));
print(allProducts.price);
          return allProducts;
        }).toList();
      } catch (e) {
        print("Exception $e");
        return [];
      }
    }
    return [];
  }


static  List<Product> cartList = List<Product>();

  static var CartNumber=0.obs;
static var total=0;
  static var category="electronics".obs;
   static FirebaseUser user;

}