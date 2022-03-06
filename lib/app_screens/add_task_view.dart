import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/commons/common_providers/task_provider.dart';
import 'package:to_do_app/commons/common_widgets/default_button.dart';
import 'package:to_do_app/commons/common_widgets/default_form_field.dart';
import 'package:to_do_app/utilites/size_config.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top:SizeConfig.padding),
        child: SingleChildScrollView(
          child: Consumer<TaskProvider>(
            builder: (context, provider , child){
              return Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    DefaultFormField(
                      controller: provider.titleController,
                      type: DefaultFormFieldType.TEXT,
                      label: 'Task title',
                      subject: provider.titleSubject,
                      focusNode: provider.titleFocusNode,
                    ),
                    DefaultFormField(
                      controller: provider.descriptionController,
                      type: DefaultFormFieldType.TEXT,
                      label: 'Task description',
                      subject: provider.descriptionSubject,
                      focusNode: provider.descriptionFocusNode,
                    ),
                    DefaultButton(text: 'Save', function: () {
                      provider.createNewTask();
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
