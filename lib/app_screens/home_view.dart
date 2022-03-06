import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_screens/add_task_view.dart';
import 'package:to_do_app/app_screens/edit_task_view.dart';
import 'package:to_do_app/commons/common_providers/task_provider.dart';
import 'package:to_do_app/commons/commons_models/task_model.dart';
import 'package:to_do_app/database/db_helper.dart';
import 'package:to_do_app/utilites/Constants/app_colors.dart';
import 'package:to_do_app/utilites/size_config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    dbHelper.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<TaskProvider>(builder: (context, provider, child) {
        return StreamBuilder(
            stream: provider.getTasksData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('${snapshot.data} snapshot datataaaaaaa ');
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    TaskModel taskModel =
                        TaskModel.fromMap(snapshot.data[index]);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditTaskView(taskModel: taskModel),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            taskModel.title.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          subtitle: Text(
                            taskModel.description.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greyColor,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.redColor,
                              size: SizeConfig.iconSize,
                            ),
                            onPressed: () {
                              provider.deleteTask(taskModel.id as int);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "No Tasks Add Yet",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.blackColor,
                    ),
                  ),
                );
              }
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTaskView(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
