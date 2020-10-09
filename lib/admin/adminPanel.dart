import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mykart/admin/categories.dart';
class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
              Padding(
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

                              Icon(
                                Icons.delete,
                              ),

                            ],
                          ),

                          SizedBox(
                            height: 16,
                          ),

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


                            ],
                          ),

                        ],
                      ),
                    )
                  ],

                ),
              ),
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
              Icon(Icons.directions_transit),

            ],
          ),
        ),
      );

  }
}
