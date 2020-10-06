import 'dart:async';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mykart/ProductPage.dart';
import 'package:mykart/loginScreen.dart';
import 'package:mykart/models/Product.dart';
import 'package:mykart/widgets/CategoryItem.dart';

import 'cart.dart';

class HomePage extends StatefulWidget {
  FirebaseUser user;

  HomePage([this.user]);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  FirebaseUser loginuser;

 // List<Product> _cartList = List<Product>();

  int CartNumber=0;
  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>samaan;

  final CollectionReference collectionReference=
  Firestore.instance.collection("electronics");



  List bannerAdSlider = [
    "assets/banner1.jpg",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
    "assets/banner4.jpg",
    "assets/banner5.jpg",
    "assets/banner6.jpg",
    "assets/banner7.jpg",
    "assets/banner8.jpg"
  ];


  Future<List<Product>> products;

//   Future<List<Product>> products = [
////    Product(
////        image: "assets/product1.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price: 200,
////        productName: "iPad mini",
////        qty:0
////    ),
////
////    Product(
////        image: "assets/product2.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  20,
////        productName: "iPad Pro",
////        qty:0),
////    Product(
////        image: "assets/product3.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  220,
////        productName: "iPhone Pro Max",
////        qty:0),
////    Product(
////        image: "assets/product4.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  210,
////        productName: "Apple Watch Series 3",
////        qty:0),
////    Product(
////        image: "assets/product5.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  300,
////        productName: "Apple Watch Series 4",
////        qty:0),
////    Product(
////        image: "assets/product6.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  240,
////        productName: "Macbook Pro 16 inch",
////        qty:0),
////    Product(
////        image: "assets/product7.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "Macbook Pro",
////        qty:0),
////    Product(
////        image: "assets/product8.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "iMac 4k Retina",
////        qty:0),
////    Product(
////        image: "assets/product9.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "T-Shirts",
////        qty:0),
////    Product(
////        image: "assets/product10.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "Ethnic Wear - Dress",
////        qty:0),
////    Product(
////        image: "assets/product11.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "Dress",
////        qty:0),
////    Product(
////        image: "assets/product12.jpg",
////        description:
////            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
////        price:  200,
////        productName: "T-Shirt",
////        qty:0),
//  ];

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();



  @override
  void dispose() {
    // TODO: implement dispose

    subscription?.cancel();
    super.dispose();

  }



  @override
  void initState() {
    // TODO: implement initState
loginuser=widget.user;
  //loggedinuser();
    super.initState();
subscription=collectionReference
    .snapshots()
    .listen((datasnapshot){


  setState(() {
    samaan=datasnapshot.documents;
  });


});

Product.getAllData();

  }

  loggedinuser() async {
    await FirebaseAuth.instance.currentUser().then((firebaseUser) {
      if (firebaseUser == null) {
        //signed out
      } else if (firebaseUser != null){

        //print(firebaseUser.phoneNumber);
        //signed in
loginuser=firebaseUser;
        print(loginuser.phoneNumber);

//       setState(() {
//         logedIN=true;
//       });

      }
    });
  }


  @override
  Widget build(BuildContext context) {
print("chl2");
//print(loginuser.phoneNumber);


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));



    return Scaffold(
      key: drawerKey,

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Parash",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
        actions: <Widget>[





          Badge(

            badgeColor: Colors.red,
            position: BadgePosition.topLeft(top: 10,left: -1),
            badgeContent:Obx(() => Text(Product.CartNumber.string,
              style: TextStyle(color: Colors.white),
            ),


            ),
//            Text(Product.CartNumber.toString(),
//            style: TextStyle(color: Colors.white),
//            ),
            child: IconButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Cart()),
                );


              },
              icon: Icon(EvaIcons.shoppingBagOutline,

              size: 30,),
            ),
          ),
        ],
      ),
      drawerEdgeDragWidth: 0,
      drawer: FutureBuilder(
        future: loggedinuser(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {

     return Drawer(
        child: ListView(
          children: <Widget>[
//            UserAccountsDrawerHeader(
//              decoration: BoxDecoration(
//                color: Colors.amber,
//                borderRadius: BorderRadius.circular(16),
//              ),
//              accountEmail: Text(
//                "person@mail.com",
//                style: TextStyle(
//                  color: Colors.black,
//                ),
//              ),
//              accountName: Text(
//                "Allice",
//                style: TextStyle(
//                  color: Colors.black,
//                ),
//              ),
////              currentAccountPicture: ClipRRect(
////                borderRadius: BorderRadius.circular(70),
////                child: Image(
////                  image: NetworkImage(
////                      "https://images.pexels.com/photos/1065084/pexels-photo-1065084.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
////                  width: 70,
////                  height: 70,
////                  fit: BoxFit.cover,
////                ),
////              ),
//            ),


            Center(child: Container(child: Column(
              children: [
                Text("PARASH STORE",
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),

                ),
                loginuser!=null?
                Text(loginuser.phoneNumber,
                  style: TextStyle(fontSize: 20,color: Colors.green),

                ):Text(""),


              ],
            ),)),

            Divider(thickness: 0.2,color: Colors.black,),
            SizedBox(height: 22,),


            loginuser==null?
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>LoginScreen()),
                );

              },
              title: Text("Login"),
              leading: Icon(EvaIcons.person),

            ): ListTile(
              title: Text("Address"),
              leading: Icon(FontAwesomeIcons.addressBook),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Cart()),
                );

              },
              title: Text("Mycart"),
              leading: Icon(EvaIcons.shoppingBag),
              trailing: Badge(
                badgeContent:Obx(() => Text(Product.CartNumber.string,
                  style: TextStyle(color: Colors.white),
                ),


                ),
              ),
            ),

            SizedBox(height: 10),
            ListTile(
              title: Text("Orders"),
              leading: Icon(FontAwesomeIcons.shoppingBag),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Electronics"),
              leading: Icon(FontAwesomeIcons.lightbulb),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Clothes"),
              leading: Icon(FontAwesomeIcons.tshirt),
            ),
            SizedBox(height: 10),
            loginuser!=null?
            ListTile(
              onTap: (){
                Logout();
              },
              title: Text("Log Out"),
              leading: Icon(FontAwesomeIcons.signOutAlt),
            ):Text(""),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(16),
//                child: AspectRatio(
//                  aspectRatio: 16/5,
//                  child: Image.asset(
//                    "assets/banner8.jpg",
//                    fit: BoxFit.cover,
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      );

    }
        else{
        return  CircularProgressIndicator();
    }

        }

      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Card(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  onChanged: (value){
                    print(value);

                  },
                  decoration: InputDecoration(
//          prefixIcon: Icon(Icons.person, color: Colors.black26,),
                      suffixIcon: Icon(Icons.search, color: Colors.amber,),
                      hintText: "Search Items",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(

                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              // banner ad slider

              CarouselSlider(

                options: CarouselOptions(

                  aspectRatio: 16 / 8,
                  autoPlay: true,
                ),
                items: bannerAdSlider.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(i),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              // banner ad slider

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              FutureBuilder<List<Product>>(

                future: Product.getAllData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print("just lngth"+snapshot.data.length.toString());
        return GridView.builder(
            physics: ClampingScrollPhysics(),
          shrinkWrap: true,
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              childAspectRatio: 1/2
            ),
            itemBuilder: (context, index) {
              return  Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: snapshot.data[index].image,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Material(

                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(
                                              product: snapshot.data[index],
                                            ),
                                      ));
                                },
                                child: Image(
                                  image: NetworkImage(snapshot.data[index].image),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          snapshot.data[index].productName,
                        ),
                        Text(
                          "RS ${snapshot.data[index].price}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.amber,
                          ),
                        ),

                        FlatButton(onPressed: () {
                          addItemtoCart(snapshot.data[index]);
                        },
                          splashColor: Colors.black12,
                          child: Text("Add to cart",
                            style: TextStyle(color: Colors.white),

                          ),
                          color: Colors.black,
                        )

                      ],
                    ),
                  ),
//                      Material(
//                        color: Colors.transparent,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => ProductPage(
//                                    product: product,
//                                  ),
//                                ));
//                          },
//                        ),
//                      )
                ],
              );;
            }
        );





        GridView.count(
            physics: ClampingScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1 / 2,

            // children: products.map((product)
            children: Product.getAllData().then((product) {
              for (var task in product) {
                print(task.productName);
                return Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag: task.image,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Material(

                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductPage(
                                                product: task,
                                              ),
                                        ));
                                  },
                                  child: Image(
                                    image: NetworkImage(task.image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            task.productName,
                          ),
                          Text(
                            "RS ${task.price}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.amber,
                            ),
                          ),

                          FlatButton(onPressed: () {
                            addItemtoCart(product);
                          },
                            splashColor: Colors.black12,
                            child: Text("Add to cart",
                              style: TextStyle(color: Colors.white),

                            ),
                            color: Colors.black,
                          )

                        ],
                      ),
                    ),
//                      Material(
//                        color: Colors.transparent,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => ProductPage(
//                                    product: product,
//                                  ),
//                                ));
//                          },
//                        ),
//                      )
                  ],
                ); // do something
              }
            }


            ) as List
//                    .toList(),
        );
      }

else
  {
    return Center(child: CircularProgressIndicator());
  }



    }
              )
              ,
            ],
          ),
        ),
      ),
    );



  }



   Logout()async{

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut().then((_) {
//      Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (context) => SelectCategory()),
//            (Route<dynamic> route) => false,
//      );


    SystemNavigator.pop();
    });




  }







  void addItemtoCart(products) {


//products.qty=0;

      Product.CartNumber++;

      Product.total=Product.total+products.price;


if(Product.cartList.contains(products))
  {
  //  var QTY=products.qty+1;
    Product(qty:products.qty=products.qty+1
    );

   // products.qty=products.qty+1;




  }
else{
  Product.cartList.add(products);
  //var QTY=products.qty+1;
  Product(qty:products.qty=products.qty+1
  );
 // Product.total=Product.total+(products.price*products.qty);
  //Product.total=Product.total+(products.price*products.qty);
}
//var itemResult=(products.price*products.qty);

print("Qty"+products.qty.toString());
      print(Product.total);
  //  Product.cartList.add(products);
    print(Product.cartList.toList());

    drawerKey.currentState.showSnackBar(new SnackBar(content: new Text("Item Added"),
      duration: const Duration(milliseconds:200 ),
      action: SnackBarAction(

        label: 'Close',
        textColor: Colors.blue,
        onPressed: () {
          // Some code to undo the change.
        },
      ),

    ));



  }

}
