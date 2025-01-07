//name,username,password,confirm password

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled1/login%20using%20hive/db/database.dart';
import 'package:untitled1/login%20using%20hive/model/usermodel.dart';



class Registrationpage extends StatefulWidget {
  const Registrationpage({super.key});

  @override
  State<Registrationpage> createState()=>_Registrationpage();
}

class _Registrationpage extends State<Registrationpage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Registration page", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Colors.white12,
        child: Form(
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
                padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
                child: TextFormField(controller: username,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "username",
                    hintText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
                child: TextFormField(controller: password,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "password",
                      hintText: "password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    )),
              ),
        Padding(
             padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
            child: TextFormField(controller: confmpassword,
               obscuringCharacter: "*",
               decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock),
                   labelText: "confirm password",
                   hintText: "confirm password",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 )

             ),
           ),
        ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      validateSignUp();
                    },
                    child: Text("Register")),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void validateSignUp() async {
    final email = username.text.trim();
    final pass = password.text.trim();
    final cpass = confmpassword.text.trim();

    final emailValidationResult = EmailValidator.validate(email);

    if (email != "" && pass != "" && cpass != "") {
      if (emailValidationResult == true) {
        final passValidationResult = checkPassword(pass, cpass);
        if (passValidationResult == true) {
          final user = User(email: email, password: pass);
          await DBFunction.instance.userSignup(user);
          Get.back();
          Get.snackbar("Success", "Account created");
        }
        }
        else {
          Get.snackbar("Error", "Provide a valid Email");
        }
      }
      else {
        Get.snackbar("Error", "Fields cannot be empty");
      }
    }
  }

  bool checkPassword(String pass, String cpass) {
    if (pass == cpass) {
      if (pass.length < 6){
        Get.snackbar("Error", "Password length should be >6");
        return false;
      }
      else {
        return true;
      }
    }
    else {
      Get.snackbar("Error", "Password mismatch");
      return false;
    }
  }
