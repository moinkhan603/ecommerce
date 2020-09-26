import 'package:flutter/material.dart';
import 'package:mykart/models/Product.dart';
class OrderPlacement extends StatefulWidget {
  @override
  _OrderPlacementState createState() => _OrderPlacementState();
}

class _OrderPlacementState extends State<OrderPlacement> {
  @override
  Widget build(BuildContext context) {


    TextStyle mystyle=TextStyle(fontSize: 20,);
    TextStyle mystyle2=TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
    return Scaffold(
bottomNavigationBar: FlatButton(child:
  Text("Place Order",style: TextStyle(color: Colors.white),),
  color: Colors.black,
  onPressed: (){

  },
splashColor: Colors.white70,
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
                      new Flexible(
                        child: new TextField(

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Your Address",
                              hintMaxLines: 5
                            ),
maxLines: 3,
                            onChanged: (value) {

                            }),


                      ),

                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize
                        .max,
                    children: <Widget>[
                      new Flexible(
                        child: new TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Your Number",

                            ),

                            onChanged: (value) {

                            }),


                      ),

                    ],
                  )),


          ],),
        ),
      ),



    );
  }
}
