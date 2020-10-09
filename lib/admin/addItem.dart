import 'package:flutter/material.dart';
class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: ListView(

          physics:BouncingScrollPhysics(),
          padding: EdgeInsets.all(11),

          children: [
            Center(
              child:   Text("Add Image That Shows your Gig",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 10,
            child: Container(
              height: 250,
              width:double.infinity,
              child:
              InkWell(
                  onTap: (){
                 //   chooseFile();
                  },
                  child:Image.asset("assets/add.png")
              )
              ),
            ),
            SizedBox(height: 20,),
            Text("Add Product Name",style: TextStyle(
                fontSize: 22)),
            SizedBox(height: 20,),
            TextField(

              onChanged: ((value){
               // title=value;
              }),
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "e.g : surf excel",
                  fillColor: Colors.white70),
            ),
            SizedBox(height: 20,),
            Text("Add  Product Description",style: TextStyle(
                fontSize: 22)),
            SizedBox(height: 20,),
            TextField(
              onChanged: ((value){
               // description=value;
              }),
              maxLines: 5,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your text",
                  fillColor: Colors.white70),
            ),
            SizedBox(height: 20,),
          Text("Add Quantity",style: TextStyle(
                fontSize: 22

            ),),
            SizedBox(height: 20,),
            TextField(

              onChanged: ((value){
                //time=value;
              }),
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "e.g 20 ",
                  fillColor: Colors.white70),
            ),
            SizedBox(height: 20,),
            Text("Price in PKR",style: TextStyle(
                fontSize: 22

            ),),
            SizedBox(height: 20,),
            TextField(
              onChanged: ((value){
                //price=value;
              }),
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "e.g:50",
                  fillColor: Colors.white70),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              child: RaisedButton(

                elevation: 12,
                child:Text("Create",
                  style: TextStyle(color: Colors.white,fontSize: 23),
                ),
                onPressed: (){

//              if(title==null || description==null || time==null || _image==null || price== null)
//              {
//
//
//                Fluttertoast.showToast(msg: "All fields are required");
//
//
//              }
//              else{
//
//              //  UploadGig();
//
//              }




                },
                color: Colors.black,

              ),
            )
          ],)
      ),
    );
  }
}
