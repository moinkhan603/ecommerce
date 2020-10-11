import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mykart/admin/categories.dart';
class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>samaan;

  final CollectionReference collectionReference=
  Firestore.instance.collection("orders");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription=collectionReference.
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
    subscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return    DefaultTabController(

        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.firstOrder, color: Colors.black),
                      SizedBox(width: 10,),
                      Text('In Progress ', style: TextStyle(color: Colors.black)),
                    ],
                  ),

                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.checkCircle, color: Colors.black),
                      SizedBox(width: 10,),
                      Text('delivered ', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),

              ],
            ),
            title: Text('ADMIN PANEL',style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold
            ),

            ),
  centerTitle: true,
          ),
          body: TabBarView(
            children: [
          Stack(
            children: [
              samaan!=null?
              ListView.builder(
                  itemCount: samaan.length,
                  itemBuilder: (BuildContext ctxt, int index) {
      String address = samaan[index].data['address'];
      List<dynamic> names = samaan[index].data["order_details"];

      String  docID=samaan[index].documentID;

//mylist.add(Text(names[index]['name']));
//mylist.add(Text(names[index]['qty']));
      print(docID);

      String status = samaan[index].data['status'];
      String phn = samaan[index].data['phoneNumber'];
      int total = samaan[index].data['total_amount'];
     if(status.contains("pending")||status.contains('Confirm'))
        {
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
                                     phn,
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

                          Icon(
                            Icons.delete,
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text("Address",style: TextStyle(color: Colors.black,fontSize: 22),),
                      Text(address),
                      Divider(color: Colors.black,),
                      Text("status",style: TextStyle(color: Colors.black,fontSize: 22),),
                      Text(status),
                      Divider(color: Colors.black,),
                      Column(

                        children: <Widget>[
                          SizedBox(
                            height:200,
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
                              child: InkWell(
                                onTap:(){
                                  print(docID);
                                  updateProfileData(docID,"Confirm");
                                },
                                child: Center(
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.blue
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: InkWell(
                                onTap:(){
                                  updateProfileData(docID,"delivered");
                    },
                                child: Center(
                                  child: Text(
                                    "Deliver",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green
                                    ),
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
     else{
       return Container();
     }

    }


              ):Center(child: CircularProgressIndicator()),


              Positioned.fill(
                bottom: 80,
                right: 20,
                child: Align(

                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    child:
                    Icon(FontAwesomeIcons.pen)
                    ,
                  onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Categories()),
        );
                  },

                  ),
                ),
              )
            ],


          ),
              samaan!=null?
              ListView.builder
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
                    int total = samaan[index].data['total_amount'];
                    if(status=="delivered")
                    {
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
                                                  "+923065172522",
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
                                  Divider(color: Colors.black,),
                                  Text("status",style: TextStyle(color: Colors.black,fontSize: 22),),
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
                                              "Delivered",
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

                  }


              )
                  :Center(child: CircularProgressIndicator()),

            ],
          ),
        ),
      );

  }
updateProfileData(docID,status)
  async{
    await Firestore.instance.collection("orders").document(docID).updateData({

      'status':status,



    }).then((value) {

      print(' data updated');

    }).catchError((onError){

      print('Failed to Update data');

    });



  }



}
