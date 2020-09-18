import 'package:flutter/material.dart';
import 'package:mykart/models/Product.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();

  List<Product> _cartList = List<Product>();

  Cart(this._cartList);

}

class _CartState extends State<Cart> {


  int total=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: Container(
        height: 50,
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


          Text("Proceed to checkout",
          style: TextStyle(color: Colors.white),),
          Row(
            children: [
              Text("PKR $total",
                  style: TextStyle(color: Colors.white)

              ),
              Icon(Icons.chevron_right
              ,color: Colors.white,)
            ],
          ),



        ],),
      ),
      appBar: AppBar(

        title: Text("CART",
        style: TextStyle(color: Colors.black),
        ),
centerTitle: true,
elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
physics: BouncingScrollPhysics(),

        itemCount: widget._cartList.length,
    itemBuilder: (BuildContext ctxt, int index) {

      var item = widget._cartList[index];

  total=total+ int.parse(item.price);

      return ListTile(

        leading: Image.asset(item.image,

        ),
        trailing: InkWell(
            onTap: (){

              widget._cartList.remove(item);
              setState(() {

              });
            },

            child: Icon(Icons.cancel)),
        title: Text(item.productName),
        subtitle: Text(item.price),
      );



    }


      )

      
    );
  }
  
  
  
  
  
}



//class cartList extends StatelessWidget {
//
//  var item;
//  cartList(this.item);
//
//  @override
//  Widget build(BuildContext context) {
//    return
//  }
//}

