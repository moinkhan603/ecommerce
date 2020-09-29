import 'package:flutter/material.dart';
import 'package:mykart/OrderPlacement.dart';
import 'package:mykart/models/Product.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();

 // List<Product> _cartList = List<Product>();

  Cart();

}


class _CartState extends State<Cart> {



  int total=0;


  @override
  Widget build(BuildContext context) {



    return Scaffold(


      bottomNavigationBar:
      Product.CartNumber!=0?
      InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderPlacement()),
          );
        },
        child: Container(
          height: 50,
          color: Colors.orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


            Text("Proceed to checkout",
            style: TextStyle(color: Colors.white),),
            Row(
              children: [
                Text("PKR "+Product.total.toString(),
                    style: TextStyle(color: Colors.white)

                ),
                Icon(Icons.chevron_right
                ,color: Colors.white,)
              ],
            ),



          ],),
        ),
      ):
       Text(""),
      appBar: AppBar(

        title: Text("CART",
        style: TextStyle(color: Colors.black),
        ),
centerTitle: true,
elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:
      Product.CartNumber!=0?
      ListView.builder(
physics: BouncingScrollPhysics(),

        itemCount: Product.cartList.length,
    itemBuilder: (BuildContext ctxt, int index) {

      var item = Product.cartList[index];

  total=total+ int.parse(item.price.toString());

      return ListTile(

        leading: Image.asset(item.image,

        ),
        trailing: InkWell(
            onTap: (){

              Product.cartList.remove(item);
              setState(() {
                //if(Product.CartNumber!=0)

                if(Product.cartList!=null)
                {
                    Product.CartNumber=Product.CartNumber-item.qty;
                    Product.total=Product.total-(item.price*item.qty);
                  item.qty=0;
                  }

              });
            },

            child: Icon(Icons.cancel)),
        title: Text(item.productName),
       // subtitle: Text("RS "+item.price.toString()),

      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("RS "+item.price.toString()),

        Text("Qty x "+item.qty.toString(),style: TextStyle(color: Colors.orange,
        fontWeight: FontWeight.bold
        ),)

      ],),

      );



    }


      ):
          Container(child: Center(
            child: Text("No Items Added Yet",
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20),

            ),
          ),)

      
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

