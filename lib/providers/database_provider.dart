import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prueba_gbp/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();


  Future<Database> get database async {

    if(_database != null ) return _database;

    _database = await initDB();
    return _database;

  }

  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'TasksDB.db');
    final tasksDb = await openDatabase(path, version:1, onCreate: (Database db, int version) async {
      var sql1 = 'CREATE TABLE Tasks ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'userId TEXT,'
      'task TEXT,'
      'date TEXT,'
      'isDone TEXT'
      ')';

      var sql2 = 'CREATE TABLE Completed ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'userId TEXT,'
      'task TEXT,'
      'date TEXT,'
      'isDone TEXT'
      ')';
      await db.execute(sql1);
      await db.execute(sql2);
    });

    return  tasksDb;

  }


  Future<Task> newTask( Task task ) async {

    final db  = await database;
    task.id = await db.insert('Tasks',  task.toMap() );
    return task;
  }

  Future<List<Task>> getTaskByUser(String userId) async {

    final db  = await database;
    final res = await db.rawQuery("SELECT * FROM Tasks WHERE userId='$userId'");
    
    List<Task> list = res.isNotEmpty
                        ? res.map((e) => Task.fromJson(e)).toList()
                        : [];
    return list;

  }
  Future<List<Task>> getCompletedTaskByUser(String userId) async {

    final db  = await database;
    final res = await db.rawQuery("SELECT * FROM Completed WHERE userId='$userId'");
    
    List<Task> list = res.isNotEmpty
                        ? res.map((e) => Task.fromJson(e)).toList()
                        : [];
    return list;

  }

  Future<Task> completedTask(Task task) async{
    final db = await database;
    task.id = await db.insert('Completed', task.toMap());
    return task;

  }

  Future<int> deleteTask(int id)async{
    final db = await database;
    final res = await db.delete('Tasks', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Tasks');
    return res;
  }


}
