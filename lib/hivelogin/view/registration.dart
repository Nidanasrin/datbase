//name,username,password,confirm password

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/hivelogin/db/sqllhelper.dart';
import 'package:untitled1/sqlfliteg/sqlhelper.dart';
import 'package:untitled1/sqlflitelogin/view/login.dart';
import 'package:untitled1/sqlflitelogin/view/splash.dart';

void main() {
  runApp(MaterialApp(
    home: Registrationnn(),
  ));
}

class Registrationnn extends StatefulWidget {
  const Registrationnn({super.key});

  @override
  State<Registrationnn> createState()=>_Registrationnn();
}

class _Registrationnn extends State<Registrationnn> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool confrmpass=true;
  bool showpass=true;
  var formkey1=GlobalKey<FormState>();
  var conname=TextEditingController();
  var conemail=TextEditingController();
  var pass=TextEditingController();
  var cpass=TextEditingController();


  @override
  Widget build(BuildContext context) {

    void adduser(String name,String email,String password)async{
      var id=await Sqllhelper.Adduser(name,email,password);

      if(id!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Logins()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splashscreen()));
      }
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Registration page",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Colors.white12,
        child: Form(
          key:formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Registration page",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 50),
                child: TextFormField(controller: conname,
                  decoration: InputDecoration(
                      labelText: "name",
                      hintText: "name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator:(name){
                    if(name!.isEmpty){
                      return "valid name";
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 100, right: 100),
                child: TextFormField(controller: conemail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "username",
                    hintText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (username) {
                    if (username!.isEmpty || !username.contains("@") ||
                        !username.contains(".com")) {
                      return "enter valid email";
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 100, right: 100),
                  child: TextFormField(controller: pass,
                    obscureText: showpass,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "password",
                        hintText: "password",
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            if (showpass){
                              showpass=false;
                            }
                            else{
                              confrmpass=true;
                            }
                          });
                        },
                            icon: Icon(confrmpass==true? Icons.visibility_off: Icons.visibility )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, left: 100, right: 100),
              //   child: TextFormField(controller: cpass,
              //     obscureText: confrmpass,
              //     obscuringCharacter: "*",
              //     decoration: InputDecoration(
              //         labelText: "confirm password",
              //         hintText: "confirm password",
              //         suffixIcon: IconButton(onPressed: (){
              //           setState(() {
              //             if(confrmpass){
              //               confrmpass=false;
              //             }
              //             else{
              //               confrmpass=true;
              //             }
              //           });
              //         }, icon: Icon(confrmpass==true ? Icons.visibility_off:Icons.visibility)),
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30))),
              //
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      var valid=formkey.currentState!.validate();
                      if(valid){
                        String eemail=conemail.text;

                        var data= await Sqlhelper.userfound(eemail);
                        if (data.isNotEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User already exists'))
                          );
                        }
                        else{
                          adduser(conname.text,conemail.text,pass.text);
                        }
                      }
                    },
                    child: Text("Register")),
              ),

            ],
          ),
        ),
      ),
    );
  }
}