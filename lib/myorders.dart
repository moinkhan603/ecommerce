import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mykart/models/Product.dart';
class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();



}

class _MyOrdersState extends State<MyOrders> {

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>samaan;

  final CollectionReference collectionReference=
  Firestore.instance.collection("orders");

  @override
  void initState() {


    print("check wali cc"+Product.user.uid);
    // TODO: implement initState
    super.initState();
    subscription=collectionReference.where('phoneNumber',
        isEqualTo: Product.user.phoneNumber).


    snapshots()
        .listen((datasnapshot){


      setState(() {
        samaan=datasnapshot.documents;
      });


    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
//    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      samaan!=null?
    Material(
      child: ListView.builder
        (
          itemCount: samaan.length,
          itemBuilder: (BuildContext ctxt, int index) {
            String address = samaan[index].data['address'];
            List<dynamic> names = samaan[index].data["order_details"];

            String  docID=samaan[index].documentID;

//mylist.add(Text(names[index]['name']));
//mylist.add(Text(names[index]['qty']));
            print(docID);

            String status = samaan[index].data['status'];
            String phnNO = samaan[index].data['phoneNumber'];
            int total = samaan[index].data['total_amount'];

  return Padding(
    padding: EdgeInsets.only(right: 32, left: 32, bottom: 8),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [

              Row(
                children: [



                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Order details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              Product.user.phoneNumber,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),

                          ],
                        ),
                      )
                  ),



                ],
              ),

              SizedBox(
                height: 16,
              ),
              Text("Address",style: TextStyle(color: Colors.black,fontSize: 22),),
              Text(address),
              //Divider(color: Colors.black,),
              //Text("status",style: TextStyle(color: Colors.black,fontSize: 22),),
              Text(status),
              Divider(color: Colors.black,),
              Column(

                children: <Widget>[
                  SizedBox(
                    height:100,
                    child: ListView.builder(

                        itemCount: names.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          //  print("kikiki"+names.length.toString());
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(names[index]['name'],style: TextStyle(fontSize: 21),),
                              Text("q x "+names[index]['qty'].toString(),style: TextStyle(fontSize: 20)),

                            ],);
                        }

                    ),
                  )
                ],
              )
              ,


              Divider(color: Colors.black,),
              Text("total",style: TextStyle(color: Colors.black,fontSize: 22),),
              Text(total.toString()),
              Divider(color: Colors.black,),

              Row(
                children: [


                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),

            ],
          ),
        )
      ],

    ),
  );



          }


      ),
    )
        :Center(child: Text("No Orders yet"));

  }
}
