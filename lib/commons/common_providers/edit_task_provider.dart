import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_app/commons/commons_models/task_model.dart';
import 'package:to_do_app/database/db_helper.dart';

class EditTaskProvider extends ChangeNotifier{
  late TaskModel taskModel;
  EditTaskProvider({required this.taskModel});
  BehaviorSubject<String> titleSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> descriptionSubject = BehaviorSubject.seeded("");
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  DbHelper dbHelper = DbHelper();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  getTaskData(){
    titleSubject.sink.add(taskModel.title);
    descriptionSubject.sink.add(taskModel.description);

    titleController.text = taskModel.title;
    descriptionController.text = taskModel.description;
  }

  updateTaskInfo()  {
    TaskModel updateTask = TaskModel({
      'id' : taskModel.id,
      'firstName' : titleSubject.value,
      'lastName' : descriptionSubject.value,
    });
    dbHelper.editTaskInfo(updateTask);
    notifyListeners();
  }

}