import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
  String type;
  AddItem(this.type);

}

class _AddItemState extends State<AddItem> {
  File _image;
  String productName;
  String productDescription;
  int qty;
  int price;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: ListView(

            physics:BouncingScrollPhysics(),
            padding: EdgeInsets.all(11),

            children: [
              Center(
                child:   Text("Add Product Image",style: TextStyle(
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
                      chooseFile();
                    },
                   child: _image==null?
                    Image.asset('assets/add.png',

                      fit: BoxFit.cover,
                    ):
                    Image.file(_image)
                )
                ),
              ),
              SizedBox(height: 20,),
              Text("Add Product Name",style: TextStyle(
                  fontSize: 22)),
              SizedBox(height: 20,),
              TextField(

                onChanged: ((value){
                  productName=value;
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
                  productDescription=value;
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

                keyboardType: TextInputType.number,

                onChanged: ((value){
                  qty= int.parse(value);


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
                keyboardType: TextInputType.number,
                onChanged: ((value){
                  price=int.parse(value);
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

                if(productName==null || productDescription==null || qty==null || _image==null || price== null)
                {


                  Fluttertoast.showToast(msg: "All fields are required");


                }
                else{

                  UploadGig();

                }




                  },
                  color: Colors.black,

                ),
              )
            ],)
        ),
      ),
    );
  }
  void chooseFile() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    this.setState(() {
      _image = selected;
      print(_image);
    });


  }

  UploadGig()async{

    setState(() {
      showSpinner=true;
    });

    String gigImg;

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Recent/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        gigImg=fileURL;


        // showSpinner = false;
      });

      print(gigImg);
      Firestore.instance.collection(widget.type).document().setData({
        'name':productName,
        'img':gigImg,
        'price':price,
        'description':productDescription,
        'quantity':qty

      })
          .then((value) {

        print('gig data added');
        Fluttertoast.showToast(msg: "Product added");

      }).catchError((onError){

        print('Failed to add data');

      });
      setState(() {
        showSpinner=false;
      });



    });







//    Firestore.instance.collection(type).document(myuserid).setData({
//
//      'name':name,
//      'email':email,
//      'phone_number':phoneNumber,
//      'address':address,
//      'country':country,
//      'city':city,
//      'img':imgUrl,
//      'dob':dob,
//
//
//    })
//    .then((value) {
//
//      print('data added');
//
//    }).catchError((onError){
//
//      print('Failed to add data');
//
//    });
  }
}
