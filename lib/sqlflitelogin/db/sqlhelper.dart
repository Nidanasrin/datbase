
import 'package:sqflite/sqflite.dart' as sql;
import '../../sqlfliteg/sqlhelper.dart';

class Sqlhelpper {
  static Future<sql.Database> MyData() async {
    return sql.openDatabase('mylogin.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTable(database);
        });
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE login(
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
name TEXT,
email TEXT,
password TEXT)
""");
  }

  static Future <int> Adduser(String name, String email,
      String password) async {
    final db = await Sqlhelper.Mydata();
    final data = {"name": name, "email": email, "password": password};
    final id = await db.insert("login", data,);              //insert or rawquery
    return id;
  }

  static Future<List<Map>> userfound(String email) async {
    final db = await Sqlhelper.Mydata();
    final data = await db.rawQuery("SELECT * FROM login WHERE email=$email");
    if (data.isNotEmpty) {
      return data;
    }
    else {
      return data;
    }
  }

  static Future<List<Map>> checklogin(String email, String password) async {
    final db = await Sqlhelper.Mydata();
    final data = await db.rawQuery(
        "SELECT * FROM login email=$email AND password=$password");
    if (data.isNotEmpty) {
      return data;
    }
    else {
      return data;
    }
  }

  static Future<List<Map>> getall() async {
    final db = await Sqlhelper.Mydata();
    final data = await db.rawQuery("SELECT * FROM login");
    return data;
  }

  static Future<void> delete(int id) async {
    final db = await Sqlhelper.Mydata();
    db.delete("login", where: "id=?", whereArgs: [id]);
  }
}