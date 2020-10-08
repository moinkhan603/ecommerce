import 'package:flutter/material.dart';
import 'package:get_rx/src/rx_core/rx_impl.dart';
import 'package:mykart/models/Product.dart';
import 'package:get/get.dart';

import 'HomePage.dart';
class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Product.cartList.clear();
  Product.CartNumber.value=0;
Product.total=0;



  }
  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: _willpop,
      child: Scaffold(backgroundColor: Colors.white,

      body: Container(
        child:  Center(
      child: Text("Congratulations ! \n"
      "Your Order has been Placed",
        style: TextStyle(

          color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,),
textAlign: TextAlign.center,
      ),
      ),

      ),),
    );

      Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text("Congratulations ! \n"
            "Your Order has been Placed",
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20),

        ),
      ),);
  }

  Future<bool> _willpop() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
  }
}
