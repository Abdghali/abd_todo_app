import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../data/task.dart';

class TodoMainPageController extends GetxController {
  RxBool todoIsExpanded = true.obs;
  RxBool inProggressIsExpanded = false.obs;
  RxBool doneExpanded = false.obs;

  Rx<TextEditingController> taskNameController = TextEditingController().obs;

  RxList<Task> todoList = <Task>[
    Task(name: "Task 1", taskStatus: TaskStatus.todo, id: 1),
  ].obs;
  RxList<Task> inProgressList = <Task>[
    Task(name: "Task 2", taskStatus: TaskStatus.inProgress, id: 2),
    Task(name: "Task 3", taskStatus: TaskStatus.inProgress, id: 3),
  ].obs;
  RxList<Task> doneList = <Task>[
    Task(name: "Task 4", taskStatus: TaskStatus.done, id: 4),
  ].obs;

  RxInt count = 0.obs;

  addTaskToTodoList() {
    todoList.value
        .add(Task(id: ++count.value, name: taskNameController.value.text));
  }

  refreshExpansionPanel(ExpansionPanelType expansionPanelType) {
    print(expansionPanelType.index);
    switch (expansionPanelType) {
      case ExpansionPanelType.todo:
        todoIsExpanded.value = true;
        inProggressIsExpanded.value = false;
        doneExpanded.value = false;
        print("Todo");
        break;
      case ExpansionPanelType.inProgress:
        inProggressIsExpanded.value = true;
        doneExpanded.value = false;
        todoIsExpanded.value = false;
        print("in Progress");
        break;
      case ExpansionPanelType.done:
        doneExpanded.value = true;
        inProggressIsExpanded.value = false;
        todoIsExpanded.value = false;
        print("done");
        break;
    }
  }
}
