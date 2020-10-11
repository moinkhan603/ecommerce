import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mykart/admin/addItem.dart';

import 'banner.dart';
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Center(
        child: Container(
          child: Material(
            child: GridView.count(
              
              physics: BouncingScrollPhysics(),
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[

                categoryCard("Clothes",Icon(FontAwesomeIcons.tshirt,color: Colors.amber,size: 42,)),
                categoryCard("electronics",Icon(FontAwesomeIcons.laptop,color: Colors.red,size: 42,)),
                categoryCard("Mart",Icon(FontAwesomeIcons.shoppingBag,color: Colors.blue,size: 42,)),
                categoryCard("Others",Icon(FontAwesomeIcons.evernote,color: Colors.green,size: 42,)),
                categoryCard("Add Banner Images",Icon(FontAwesomeIcons.buysellads,color: Colors.orange,size: 42,)),


              ],
            ),
          ),
        ),
      ),
    );
  }

  categoryCard(String name,Icon data) {

    return InkWell(
      onTap: (){
        if(name.contains("Add")){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bannerz()),
          );

        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItem(name)),
          );
        }




      },
      child: Card(
        shape: RoundedRectangleBorder(


          side: new BorderSide(color: Colors.indigo, width: 2.0),
        ),


        elevation: 11,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              data,
              SizedBox(height: 20,),
              Text(name, textAlign:TextAlign.center,style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,

              )),

            ],),
          color: Colors.white,
        ),
      ),
    );
  }
}

