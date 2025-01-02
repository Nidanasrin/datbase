import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todobox');
  runApp(MaterialApp(home: hiveui(),));
}

class hiveui extends StatefulWidget {
  const hiveui({super.key});

  @override
  State<hiveui> createState() => _hiveuiState();
}

class _hiveuiState extends State<hiveui> {
  List<Map<String, dynamic>>task = [];
  final tbox = Hive.box('todobox');

  void initstate() {
    loadtask();
    super.initState();
  }

  Future<void> createtask(Map<String, dynamic>ctask) async {
    await tbox.add(ctask);
    loadtask();
  }
  void loadtask(){
    final data=tbox.keys.map((id){
      final values=tbox.get(id);
      return {"key" : id,"title" : values["title"], "subtitle" : values["subtitle"]};

}).toList();
    setState((){
  task=data.reversed.toList();
  });
  }
  Future<void>updatetask(int key,Map<String,dynamic> utask) async{
    await tbox.put(key,utask);
    loadtask();
  }
  Future<void>deletetask(int key)async{
    loadtask();
    await tbox.delete(key);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: task.isEmpty? Center(
        child: Text("No data"),):
      ListView.builder(itemBuilder: (context, index) {
        var tasknew=task[index];
        return Card(
          child: ListTile(
            title: Text(tasknew["title"]),
            subtitle: Text(tasknew["subtitle"]),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                   shofrom(tasknew["key"]);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {
                    deletetask(tasknew["key"]);
                }, icon: Icon(Icons.delete)),
              ],
            ),
          ),
        );
      }, itemCount: task.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => shofrom(null),
        child: Icon(Icons.add),),
    );
  }

  final title = TextEditingController();
  final subtitle = TextEditingController();
  shofrom( int ? id) {
    if(id!=null){
      final ex_data=task.firstWhere((data)=>data["key"]==id);
      title.text=ex_data["title"];
      subtitle.text=ex_data["subtitle"];
    }
    showModalBottomSheet(isScrollControlled: true,
        context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 120),
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "title"
                  ),
                ),
                TextField(
                  controller: subtitle,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "description"
                  ),
                ),
                ElevatedButton(onPressed: () async {
                  if (id == null) {
                    createtask({"title":title.text, "subtitle":subtitle.text});
                  }
                  if(id!=null){
                    updatetask(id, {"title" : title.text,"subtitle" : subtitle.text});
                  }
                  title.text="";
                  subtitle.text="";
                  Navigator.pop(context);
                }, child: Text(id == null ? "add" : "update"))
              ],
            ),
          );
        });
  }
}