import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/sqlflitelogin/db/sqlhelper.dart';
import 'package:untitled1/sqlflitelogin/view/homeadmin.dart';
import 'package:untitled1/sqlflitelogin/view/homeuser.dart';
import 'package:untitled1/sqlflitelogin/view/register.dart';




void main(){
  runApp(MaterialApp(home: Logins(),));
}
class Logins extends StatefulWidget{
  const Logins({super.key});

  @override
  State<Logins> createState()=>_LoginsState();

}

class _LoginsState extends State <Logins> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool showpass = true;
  var conemail=TextEditingController();
  var conpass=TextEditingController();




  void logincheck(String email, String password)async{
    if (email == 'admin@gmail.com' && password =='123456'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homeadmin()));
      print("Login success");
    }
    else{
      var data=await Sqlhelpper.checklogin(email, password);
      if(data.isNotEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homeuser(data: data)));
      }

      else if(data.isEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Registrationnn()));
        print("login failed");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey,
          title: Text("Loginpage"),),
        body: Container(
            color: Colors.greenAccent,
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "Login ",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 60, right: 60),
                    child: TextFormField(controller: conemail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "username",
                          hintText: "username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (username) {
                        if (username!.isEmpty || !username.contains("@") ||
                            !username.contains(".com")) {
                          return "enter valid email";
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 60, right: 60, bottom: 70),
                    child: TextFormField(controller: conpass,
                      obscureText: showpass,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          hintText: "password",
                          labelText: "password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              if (showpass) {
                                showpass = false;
                              }
                              else {
                                showpass = true;
                              }
                            });
                          },
                              icon: Icon(
                                  showpass == true ? Icons.visibility_off : Icons
                                      .visibility)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "enter valid password";
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: ()async{
                        var valid = formkey.currentState!.validate();
                        if (valid) {
                          await logincheck(conemail.text, conpass.text);
                        }
                      },
                      child: Text("login")),

                  SizedBox(height: 40),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Registrationnn()));
                  },
                      child: Text("Not a user ? create an account !")),
                ],
              ),
    )
        )
    );
    }
}