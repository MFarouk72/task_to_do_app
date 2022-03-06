import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier{
  int? _id;
  late String _title;
  late String _description;

  TaskModel(dynamic obj) {
    _id = obj['id'];
    _title = obj['title'];
    _description = obj['description'];
  }

  TaskModel.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _title = data['title'];
    _description = data['description'];
  }

  Map<String, dynamic> toMap() => {
    'id': _id,
    'title': _title,
    'description': _description,
  };

  int? get id => _id;

  String get title => _title;

  String get description => _description;
}
