import 'package:badges/badges.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mykart/HomePage.dart';
import 'package:mykart/models/Product.dart';

import 'cart.dart';

class ProductPage extends StatelessWidget {
  final Product product;
FirebaseUser user;
  ProductPage({@required this.product ,@required this.user });
  @override
  Widget build(BuildContext context) {

    print("helo gggg "+ user.uid);
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(
//          product.productName,
//          style: TextStyle(
//            color: Colors.black,
//          ),
//        ),
//        backgroundColor: Colors.white,
//        brightness: Brightness.light,
//        elevation: 0,
//        actionsIconTheme: IconThemeData(color: Colors.black),
//        iconTheme: IconThemeData(color: Colors.black),
//      ),


      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.productName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),

        actions: <Widget>[





          Badge(

            badgeColor: Colors.red,
            position: BadgePosition.topLeft(top: 10,left: 1),
            badgeContent: Obx(() => Text(Product.CartNumber.string,
              style: TextStyle(color: Colors.white),
            ),


            ),
            child: IconButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Cart(user)),
                );


              },
              icon: Icon(EvaIcons.shoppingBagOutline,

                size: 30,),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: product.image,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image(
                    image: NetworkImage(product.image),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  product.productName,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Text(
                  "RS ${product.price}",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Expanded(
                      child: OutlineButton.icon(

                        textColor: Colors.black,
                        color: Colors.amber,
                        icon: Icon(EvaIcons.shoppingBagOutline),
                        label: Text("Add to Cart"),
                        onPressed: (){


                          addItemtoCart(product);
                        },
                      ),
                    ),


                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItemtoCart(products) {



    Product.CartNumber++;

    Product.total=Product.total+products.price;


    if(Product.cartList.contains(products))
    {
      //  var QTY=products.qty+1;
      Product(qty:products.qty=products.qty+1
      );

      // products.qty=products.qty+1;



    }
    else{
      Product.cartList.add(products);
      //var QTY=products.qty+1;
      Product(qty:products.qty=products.qty+1
      );
      // Product.total=Product.total+(products.price*products.qty);
      //Product.total=Product.total+(products.price*products.qty);
    }
//var itemResult=(products.price*products.qty);

    print("Qty"+products.qty.toString());
    print(Product.total);
    //  Product.cartList.add(products);
    print(Product.cartList.toList());



  }

}
