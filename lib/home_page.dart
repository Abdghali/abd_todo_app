import 'package:abd_todo_app/presentations/widgets/bottom_sheet_page.dart';
import 'package:abd_todo_app/presentations/widgets/custom_%20expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'bussenis_logic/buttom_sheet_controller.dart';
import 'bussenis_logic/todo_main_page_controller.dart';
import 'data/task.dart';

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

  TodoMainPageController _todoMainPageController =
      Get.put(TodoMainPageController());
  BottomSheetController _bottomSheetController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomExpansionPanel(
                expansionPanelType: ExpansionPanelType.todo,
                isExpanded: _todoMainPageController.todoIsExpanded.value,
                title: 'TODO',
                tasks: _todoMainPageController.todoList,
                onAccept: (v) =>
                    _todoMainPageController.onAccept(ExpansionPanelType.todo),
                delete: (task) {
                  print('Delete Todo');
                  print(task.name);
                  _todoMainPageController.todoList.remove(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 0;
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
              ),
              CustomExpansionPanel(
                expansionPanelType: ExpansionPanelType.inProgress,
                isExpanded: _todoMainPageController.inProggressIsExpanded.value,
                title: 'In Progress',
                tasks: _todoMainPageController.inProgressList,
                color: Colors.yellow,
                onAccept: (v) => _todoMainPageController
                    .onAccept(ExpansionPanelType.inProgress),
                delete: (task) {
                  print('Delete InProgress');
                  print(task.name);
                  _todoMainPageController.inProgressList.remove(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 1;
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
              ),
              CustomExpansionPanel(
                expansionPanelType: ExpansionPanelType.done,
                isExpanded: _todoMainPageController.doneExpanded.value,
                title: 'Done',
                tasks: _todoMainPageController.doneList,
                color: Colors.green,
                onAccept: (v) =>
                    _todoMainPageController.onAccept(ExpansionPanelType.done),
                delete: (task) {
                  print('Delete Done');
                  _todoMainPageController.doneList.remove(task);
                },
                edit: (v) {
                  _bottomSheetController.taskNameController.value.text =
                      v.name!;
                  _bottomSheetController.radioValue.value = 2;
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetPage(
                          isEdit: true,
                          bottomSheetController: _bottomSheetController,
                        );
                      });
                },
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
