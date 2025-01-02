import 'package:flutter/material.dart';

import '../db/sqlhelper.dart';

class Homeadmin extends StatefulWidget {

  @override
  State<Homeadmin> createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {
  var data;
  void delet(int id)async{
    await Sqlhelpper.delete(id);
    Refresh();
  }
  @override
  void initState(){
    Refresh();
    super.initState();
  }

  void Refresh()async{
    var mydata=await Sqlhelpper.getall();
    setState(() {
      data=mydata;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ADMIN PAGE"),),
        body: ListView.builder(itemCount: data.length,
            itemBuilder: (context,int index){
              return Card(
                color: Colors.orange,
                child: ListTile(
                  title: Text('${data[index]['name']}'),
                  trailing: IconButton(onPressed: (){
                    delet(data[index]['id']);
                  },
                      icon: Icon(Icons.delete)),
                ),
              );
            }),
        );
    }
}
