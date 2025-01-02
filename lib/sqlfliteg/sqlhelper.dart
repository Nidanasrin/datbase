import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
class Sqlhelper{

 static Future<sql.Database> Mydata()async{
    return sql.openDatabase('mydb.db',version:1,
      onCreate: (sql.Database database,int version)async{
      await createTable(database);
      }
    );
  }
 static Future<void>createTable(sql.Database database)async{
    await database.execute("""CREATE TABLE notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    subtitle TEXT,
    createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
 static Future<int>Addnotes(String note,String subnote)async{
    final db=await Sqlhelper.Mydata();
    final data={"title":note , "subtitle": subnote};
    final id=await db.insert("notes", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
 static Future<List<Map<String,dynamic>>> readnotes()async{
   final db=await Sqlhelper.Mydata();
   return db.query("notes",orderBy: "id");
  }
  static Future<int>updatenotes(int id,String newnotes,String newsubnote)async{
   final db=await Sqlhelper.Mydata();
   final newdata={
     "title":newnotes,
     "subtitle":newsubnote,
     "createAt":DateTime.now().toString(),
   };
   final result=await db.update("note",newdata,where:"id:?",whereArgs:[id]);
   return result;
  }
 static Future<void>delete(int id)async{
   final db =await Sqlhelper.Mydata();
   try {
     await db.delete("notes", where: "id:?", whereArgs: [id]);
   }
   catch (obj){
     debugPrint("Something is wrong");
   }
 }

  static userfound(String eemail) {}
}