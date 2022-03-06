import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_app/commons/commons_models/task_model.dart';
import 'package:to_do_app/database/db_helper.dart';

class TaskProvider extends ChangeNotifier{
  BehaviorSubject<String> titleSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> descriptionSubject = BehaviorSubject.seeded("");
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  DbHelper dbHelper = DbHelper();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  createNewTask() async {
    TaskModel taskModel = TaskModel({
      'title' : titleSubject.value,
      'description' : descriptionSubject.value,
    });
    await dbHelper.addTask(taskModel);
    notifyListeners();
  }

  getTasksData()=> Stream.fromFuture( dbHelper.getAllTasks());

  deleteTask(int id) async{
    await dbHelper.deleteTask(id);
    notifyListeners();
  }
}