import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mykart/HomePage.dart';

class LoginScreen extends StatelessWidget {
  final codeController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("We will send a SMS with a\n "
                  "confirmation code to the number\n"
                ,textAlign: TextAlign.center


                ,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:   Row(

                  children: [
                    Expanded(

                      child: new TextField(


                          controller: TextEditingController()
                            ..text = "+92",



                          decoration: const InputDecoration(
                            border: OutlineInputBorder(

                            ),



                          ),
                          enabled: false,
                          onChanged: (value) {

                          }),
                    ),
                    Expanded(
                      flex: 5,
                      child: new TextFormField(


                        //maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Mobile",

                          ),

//                          onChanged: (value) {
//                            //  mobileNumber=value as RxString;
//
//
//                            setState(() {
//                              phn=value;
//                            });
//
//                            print(phn);
//                          }),
                      controller: _phoneController,

                    ),

                    )],),
              ),
              SizedBox(height: 22,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: 50,
                width: double.infinity,
                child: FlatButton(

                  child:
                  Text("Next",style: TextStyle(color: Colors.white,

                    fontSize: 20,

                  ),

                  ),

                  onPressed: (){

final phone = _phoneController.text.trim();

                    print("heloooo");
                    print(phone);
registerUser(phone, context);
                    // asyncConfirmDialog();





                  }
                  ,
                  color: Colors.black
                  ,),
              )

            ],),
        ),
      ),


    );
  }

  Future registerUser(String mobile, BuildContext context) async{

    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: "+92"+mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted:(AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((AuthResult result){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => HomePage(result.user)
            ));
          }).catchError((e){
            print(e);
          });



        },
        verificationFailed: (AuthException authException){
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async{

                        final code = codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                        AuthResult result = await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if(user != null){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => HomePage(user)
                          ));
                        }else{
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        }
    );
  }
}
