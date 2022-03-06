import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_app/commons/commons_models/task_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  DbHelper.internal();

  static late Database _db;

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db..execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY autoincrement, title TEXT, description TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
    });
    return _db;
  }

  addTask(TaskModel taskModel) async {
    Database db = await createDatabase();
   return db.insert('tasks', taskModel.toMap());
  }

  getAllTasks() async {
    Database db = await createDatabase();
    return db.query('tasks');
  }

  deleteTask(int id) async {
    Database db = await createDatabase();
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  editTaskInfo(TaskModel taskModel) async {
    Database db = await createDatabase();
    return  await db.update('tasks', taskModel.toMap(),
        where: 'id = ? ', whereArgs: [taskModel.id]);
  }
}
