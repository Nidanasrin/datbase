import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/login%20using%20hive/model/usermodel.dart';

class DBFunction{
  DBFunction.internal();
  //if the class have one object we can call instance
  //singleton class
  static DBFunction instance=DBFunction.internal();

  factory DBFunction(){
    return instance;
  }
  Future<void> userSignup(User user)async{
    final db=await Hive.openBox<User>("users");
    db.put(user.id, user);
  }
  Future<List<User>> getUser()async{
    final db=await Hive.openBox<User>("users");
    return db.values.toList();
  }
}