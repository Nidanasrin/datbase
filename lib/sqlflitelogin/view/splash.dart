import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/sqlflitelogin/view/login.dart';


void main() {
  runApp(MaterialApp(
    home: Splashscreen(),
  ));
}

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Logins()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue.shade900,Colors.blue.shade600,Colors.blue.shade200])
        ),
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            )
          ],
        )
      ),
    );
  }
}
