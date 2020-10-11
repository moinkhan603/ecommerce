import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mykart/models/Product.dart';
import 'package:mykart/result.dart';

class OrderPlacement extends StatefulWidget {
  @override
  _OrderPlacementState createState() => _OrderPlacementState();
  FirebaseUser user;
  OrderPlacement(this.user);
}

class _OrderPlacementState extends State<OrderPlacement> {

  String myaddress;
  @override
  Widget build(BuildContext context) {


    TextStyle mystyle=TextStyle(fontSize: 20,);
    TextStyle mystyle2=TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: FlatButton(child:
  Text("Place Order",style: TextStyle(color: Colors.white,
  fontSize: 18
  ),),
  color: Colors.black,
  onPressed: ()async{

          print(widget.user.uid);
          if(myaddress!=null)
            {
              await placeOrder();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Result()),
              );

            }
          else{
            Fluttertoast.showToast(msg: "Address Cannot Be Empty");
          }

  },
splashColor: Colors.white70,
  ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(

  mainAxisAlignment: MainAxisAlignment.start,
            children: [

            SizedBox(
              height: 255,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.yellow, Colors.amber],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Card(
                  color: Colors.white70,
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                      Text("SubTotal",style: mystyle,),
                      Text("RS "+Product.total.toString(),style: mystyle,)


                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                      Text("Delivery fee",style: mystyle,),
                      Text("RS 50",style: mystyle,)


                    ],),
Divider(thickness: 2,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                      Text("Total",style: mystyle2,),
                      Text("RS "+(Product.total+50).toString(),style: mystyle2,)


                    ],),


                  ],),
                ),
              ),
            )
,
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize
                        .max,
                    children: <Widget>[
                      new
                      Flexible(
                        child: new TextField(

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Your Address",
                              hintMaxLines: 5
                            ),
maxLines: 3,
                            onChanged: (value) {
myaddress=value;
                            }),


                      ),

                    ],
                  )),
//              Padding(
//                  padding: EdgeInsets.only(
//                      left: 25.0,
//                      right: 25.0,
//                      top: 20.0),
//                  child: new Row(
//                    mainAxisSize: MainAxisSize
//                        .max,
//                    children: <Widget>[
//                      new Flexible(
//                        child: new TextField(
//                            keyboardType: TextInputType.number,
//                            decoration: const InputDecoration(
//                                border: OutlineInputBorder(),
//                                hintText: "Enter Your Number",
//
//                            ),
//
//                            onChanged: (value) {
//
//                            }),
//
//
//                      ),
//
//                    ],
//                  )),


          ],),
        ),
      ),



    );
  }

  void placeOrder() async{



    List yourItemList = [];
     for (int i = 0; i < Product.cartList.length; i++)
      yourItemList.add({
        "name": Product.cartList[i].productName,
        "qty": Product.cartList[i].qty

      });



  await Firestore.instance.collection("orders").document().setData({

      'user_id':widget.user.uid,
      'phoneNumber':widget.user.phoneNumber,
      'order_details':FieldValue.arrayUnion(yourItemList),
      'status':"pending",
      'total_amount':Product.total,
      'address':myaddress

    }).then((value) {

      print('data added');


    }).catchError((onError){

      print('Failed to add data');

    });


  }
}
