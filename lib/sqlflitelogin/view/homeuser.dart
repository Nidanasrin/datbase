import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Homeuser(),));
}
class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Text("ENJOY READING",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 25),),
     bottom: AppBar(
       title: Container(
         child: TextField(
           decoration: InputDecoration(
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
             hintText: "Search for books",
             prefixIcon: Icon(Icons.search),
           ),
         ),
       ),
     ), ),
      body:
      Container(
          height: 150,width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.orangeAccent,
          ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
    children: [
        Text("Child Picture Book",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
       TextButton(style: TextButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white),onPressed: (){}, child: Text("Click to smthng"))
        ]),
          ),

bottomNavigationBar: BottomNavigationBar(
  selectedItemColor: Colors.yellow,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,    showSelectedLabels: true,
    type: BottomNavigationBarType.shifting,

    items: [
  BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.filter),label: "Borrow"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "Personal"),
]),
    );
  }
}
