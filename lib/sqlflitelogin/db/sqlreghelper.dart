
import 'package:sqflite/sqflite.dart' as sql;
class Sqlreghelper{

  static Future<sql.Database> OpenDb()async{
    return sql.openDatabase('myregdb.db',version:1,
        onCreate: (sql.Database database,int version)async{
          await createTable(database);
        }
    );
  }
  static Future<void>createTable(sql.Database database)async{
    await database.execute("""CREATE TABLE Register(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    email TEXT,
    password INTEGER,
    createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
  static Future<int> AddNewUser(String name, String email, String password) async {
    final db = await Sqlreghelper.OpenDb();
    final data = {'name': name,'email':email, 'password':password };
    final id = db.insert('user', data);           //insert or rawquery.
    return id;
  }

}
