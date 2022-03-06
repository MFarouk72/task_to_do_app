import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/commons/common_providers/edit_task_provider.dart';
import 'package:to_do_app/commons/common_providers/task_provider.dart';
import 'package:to_do_app/commons/common_widgets/default_button.dart';
import 'package:to_do_app/commons/common_widgets/default_form_field.dart';
import 'package:to_do_app/commons/commons_models/task_model.dart';
import 'package:to_do_app/utilites/size_config.dart';

class EditTaskView extends StatefulWidget {
  final TaskModel taskModel;

  const EditTaskView({Key? key, required this.taskModel}) : super(key: key);

  @override
  _EditTaskViewState createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late EditTaskProvider editTaskProvider;

  @override
  void initState() {
    super.initState();
    editTaskProvider = EditTaskProvider(taskModel: widget.taskModel);
    editTaskProvider.getTaskData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.padding),
        child: SingleChildScrollView(
          child: Form(
            key: editTaskProvider.formKey,
            child: Column(
              children: [
                DefaultFormField(
                  controller: editTaskProvider.titleController,
                  type: DefaultFormFieldType.TEXT,
                  label: 'Task title',
                  subject: editTaskProvider.titleSubject,
                  focusNode: editTaskProvider.titleFocusNode,
                ),
                DefaultFormField(
                  controller: editTaskProvider.descriptionController,
                  type: DefaultFormFieldType.TEXT,
                  label: 'Task description',
                  subject: editTaskProvider.descriptionSubject,
                  focusNode: editTaskProvider.descriptionFocusNode,
                ),
                DefaultButton(
                    text: 'Save',
                    function: () {
                      // editTaskProvider.createNewTask();
                      // Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
