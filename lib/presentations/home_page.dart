import 'package:abd_todo_app/presentations/widgets/bottom_sheet_page.dart';
import 'package:abd_todo_app/presentations/widgets/custom_%20expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bussenis_logic/buttom_sheet_controller.dart';
import '../bussenis_logic/todo_main_page_controller.dart';
import '../data/models/task.dart';
import '../data/services/local_db_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  TodoMainPageController _todoMainPageController = Get.find();
  BottomSheetController _bottomSheetController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.history)),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomExpansionPanel(
                icon: Icon(Icons.today),
                expansionPanelType: ExpansionPanelType.todo,
                isExpanded: _todoMainPageController.todoIsExpanded.value,
                title: 'TODO',
                tasks: _todoMainPageController.todoList,
                onAccept: (taskValue) {
                  _todoMainPageController.updateTaskStatus(
                      taskValue, TaskStatus.todo);
                  _todoMainPageController
                      .refreshExpansionPanel(ExpansionPanelType.todo);
                },
                delete: (task) {
                  print('Delete Todo');
                  print(task.name);
                  // _todoMainPageController.todoList.remove(task);
                  _todoMainPageController.deleteTask(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 0;
                  _bottomSheetController.updatedTask.value = v;
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
                onDoneTask: (taskValue) {
                  _todoMainPageController.updateTaskStatus(
                      taskValue, TaskStatus.done);
                },
                onExpanded: () => _todoMainPageController
                    .refreshExpansionPanel(ExpansionPanelType.todo),
              ),
              CustomExpansionPanel(
                icon: Icon(Icons.work_history_outlined),
                expansionPanelType: ExpansionPanelType.inProgress,
                isExpanded: _todoMainPageController.inProggressIsExpanded.value,
                title: 'In Progress',
                tasks: _todoMainPageController.inProgressList,
                color: Colors.yellow,
                onAccept: (taskValue) {
                  _todoMainPageController.updateTaskStatus(
                      taskValue, TaskStatus.inProgress);
                  _todoMainPageController
                      .refreshExpansionPanel(ExpansionPanelType.inProgress);
                },
                delete: (task) {
                  _todoMainPageController.deleteTask(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 1;
                  _bottomSheetController.updatedTask.value = v;

                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
                onDoneTask: (taskValue) {
                  _todoMainPageController.updateTaskStatus(
                      taskValue, TaskStatus.done);
                  _todoMainPageController
                      .refreshExpansionPanel(ExpansionPanelType.done);
                },
                onExpanded: () => _todoMainPageController
                    .refreshExpansionPanel(ExpansionPanelType.inProgress),
              ),
              CustomExpansionPanel(
                icon: Icon(Icons.done),
                expansionPanelType: ExpansionPanelType.done,
                isExpanded: _todoMainPageController.doneExpanded.value,
                title: 'Done',
                tasks: _todoMainPageController.doneList,
                color: Colors.green,
                onAccept: (taskValue) {
                  _todoMainPageController.updateTaskStatus(
                      taskValue, TaskStatus.done);
                  _todoMainPageController
                      .refreshExpansionPanel(ExpansionPanelType.done);
                },
                delete: (task) {
                  print('Delete Done');
                  // _todoMainPageController.doneList.remove(task);
                  _todoMainPageController.deleteTask(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 2;
                  _bottomSheetController.updatedTask.value = v;

                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
                onExpanded: () => _todoMainPageController
                    .refreshExpansionPanel(ExpansionPanelType.done),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheetController.clear();
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return BottomSheetPage(
                  bottomSheetController: _bottomSheetController,
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
