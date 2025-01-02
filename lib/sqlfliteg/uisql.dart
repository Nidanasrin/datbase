import 'package:flutter/material.dart';
import 'package:untitled1/sqlfliteg/sqlhelper.dart';

void main(){
  runApp(MaterialApp(home: Uisql(),));
}
class Uisql extends StatefulWidget {
  const Uisql({super.key});

  @override
  State<Uisql> createState() => _UisqlState();
}

class _UisqlState extends State<Uisql> {
 bool isloading=true;
 List<Map<String,dynamic>>note_from_db=[];
 @override
 void initState(){
   viewnotes();
   super.initState();
 }
void viewnotes()async{
   final data=await Sqlhelper.readnotes();
   setState(() {
     note_from_db=data;
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading==true ? CircularProgressIndicator() :
          ListView.builder(itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title:Text("data"),
                subtitle: Text("data"),
                trailing: Row(                     // row or wrap use akiyal mathi
                  children: [
                    IconButton(onPressed: (){
                      shoform(context, note_from_db[index]["id"]);
                    },
                        icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      delete(note_from_db[index]["id"]);
                    },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          },itemCount: note_from_db.length,),
      floatingActionButton: FloatingActionButton(onPressed: ()=>shoform(context,null),
      child: Icon(Icons.add),
      ),

    );
  }
final title=TextEditingController();
  final subtitle=TextEditingController();
  showfrom(int ? id){
    if(id!=null){
      final exsistdata=note_from_db.firstWhere((notes)=>notes["id"]==id);
      title.text=exsistdata["title"];
      subtitle.text=exsistdata["subtitle"];
    }
  }
  shoform(BuildContext context, int ? id) {
    showModalBottomSheet(isScrollControlled: true,
        context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(left: 10,right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+120),
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                ),
              ),
            ),
      TextField(
        controller: subtitle,
      decoration: InputDecoration(
      hintText: "Description",
        border: OutlineInputBorder(),
      ),
      ),
        ElevatedButton(onPressed: () async {
          if(id==null){
           await addnotes();
          }
          if(id!=null){
            await update(id);
          }
          title.text="";
          subtitle.text="";
        },
      child: Text(id == null ? "add" : "update"))
        ]),
      );
    });
  }

  Future<void> addnotes() async{
    await Sqlhelper.Addnotes(title.text, subtitle.text);
    viewnotes();
  }
  Future<void>update(int id)async{
    await Sqlhelper.updatenotes(id,title.text,subtitle.text);
    viewnotes();
  }
 Future<void>delete(int id)async{
   await Sqlhelper.delete(id);
   viewnotes();
 }
}
