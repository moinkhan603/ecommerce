import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),

            ],
          ),
        ),
      );

  }
}
