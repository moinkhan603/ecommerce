import 'dart:async';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Bannerz extends StatefulWidget {
  @override
  _BannerzState createState() => _BannerzState();
}

class _BannerzState extends State<Bannerz> {

  bool showSpinner = false;
  File _image;

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>banner;

  final CollectionReference collectionReference=
  Firestore.instance.collection("banner");



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription=collectionReference
        .snapshots()
        .listen((datasnapshot){


      setState(() {
        banner=datasnapshot.documents;
      });


    });

}


  @override
  void dispose() {
    subscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return   Material(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
            margin: EdgeInsets.only(top: 15),
            child: ListView(


              children: [
                Center(
                  child:   Text(" Add Banner Images",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
                ),
                SizedBox(height: 20,),
banner!=null?
                Container(
                  height: MediaQuery.of(context).size.height/1.2,
                  child: ListView.builder(

                      physics:BouncingScrollPhysics(),

    itemCount: banner.length,
    itemBuilder: (BuildContext ctxt, int index) {
        String images = banner[index].data['img1'];
        String docID=banner[index].documentID;
        return   Card(
          elevation: 10,
          child: Container(
              height: 250,
              width:double.infinity,
              child:
              InkWell(
                    onTap: (){
                         chooseFile(docID);
                    },
                    child:Image.network(images)
              )
          ),
        );
    }

                  ),
                ): CircularProgressIndicator()

              ],)
        ),
      ),
    );
  }
  void chooseFile(docID) async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    this.setState(() {
      _image = selected;
      print(_image);
    });

    setState(() {

      showSpinner = true;
    });

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Recent/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async{
      setState(() {
        //  _uploadedFileURL = fileURL;
        // print(fileURL);




      });

//print(CRUD.imgUrl);





      await Firestore.instance.collection('banner').document(docID).updateData({

        'img1':fileURL,



      }).then((value) {

        print('Profile data updated');

      }).catchError((onError){

        print('Failed to Update data');

      });

setState(() {
  showSpinner = false;
});

    });




  }
}
