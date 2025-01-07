import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/login%20using%20hive/db/database.dart';
import 'package:untitled1/login%20using%20hive/view/home.dart';
import 'package:untitled1/login%20using%20hive/view/registration.dart';
import '../model/usermodel.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');
  runApp(GetMaterialApp(home: Logins(),));
}
class Logins extends StatefulWidget{
  const Logins({super.key});

  @override
  State<Logins> createState()=>_LoginsState();

}

class _LoginsState extends State <Logins> {
  TextEditingController emaill=TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent,
          title: Text("Loginpage"),),
        body: Container(
            color: Colors.yellow[100],
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "Login ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 60, right: 60),
                    child: TextFormField(
                      controller: emaill,
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
                        top: 30, left: 60, right: 60, bottom: 70),
                    child: TextFormField(controller: pass,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          hintText: "password",
                          labelText: "password",
                          prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: ()async{
                        final userlist=await DBFunction.instance.getUser();
                        findUser(userlist);
                      },
                      child: Text("Login")),

                  SizedBox(height: 40),
                  TextButton(onPressed: () {
                    Get.to(Registrationpage());
                  },
                      child: Text("Not a user ? create an account !")),
                ],
              ),
            )));
  }

  Future<void> findUser(List<User> userlist) async{
    final email=emaill.text.trim();
    final password=pass.text.trim();
    bool userFound = false;
    final validate=await validateLogin(email,password);

    if(validate ==true){
      await Future.forEach(userlist, (user){
        if(user.email == email && user.password== password){
          userFound =true;
        }
        else{
          userFound = false;
        }
      });
      if(userFound == true){
        Get.offAll(()=> Home(email : email));
        Get.snackbar("success", "Login Success",
        backgroundColor: Colors.green);
      }
      else{
        Get.snackbar("Error", "Incorrect email/password",
        backgroundColor: Colors.red);
      }
    }
  }

Future<bool> validateLogin(String email, String password) async {
    if(email != "" && password != ""){
      return true;
    }
    else{
      Get.snackbar("Error","Fields cannot be empty",backgroundColor: Colors.red);
      return false;
    }
}
}