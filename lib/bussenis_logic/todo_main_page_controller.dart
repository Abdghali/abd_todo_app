import 'dart:io';

import 'package:abd_todo_app/data/Repository/task_repo.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/task.dart';

class TodoMainPageController extends GetxController {
  RxBool todoIsExpanded = true.obs;
  RxBool inProggressIsExpanded = false.obs;
  RxBool doneExpanded = false.obs;

  Rx<TextEditingController> taskNameController = TextEditingController().obs;

  RxList<Task> todoList = <Task>[].obs;
  RxList<Task> inProgressList = <Task>[].obs;
  RxList<Task> doneList = <Task>[].obs;

  RxInt count = 0.obs;
  TaskRepository _taskRepository = TaskRepository();
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

  RxList<Task> _tasks = <Task>[].obs;
  @override
  void onInit() async {
    _tasks.value = await _taskRepository.getAllTasks();
    todoList.value =
        _tasks.value.where((t) => t.taskStatus == TaskStatus.todo).toList();
    doneList.value =
        _tasks.value.where((t) => t.taskStatus == TaskStatus.done).toList();
    inProgressList.value = _tasks.value
        .where((t) => t.taskStatus == TaskStatus.inProgress)
        .toList();

    super.onInit();
  }

  getTaskIndex(Task task) {
    return _tasks.indexWhere((t) => t.id == task.id);
  }

  deleteTask(Task task) async {
    int index = getTaskIndex(task);
    await _taskRepository.deleteTask(index).then((value) {
      if (value == -1) {
        print("Something Wrong");
      } else {
        onInit();
        print("Task deleted sucessfully ");
      }
    });
  }

  updateTaskStatus(Task task, TaskStatus status) async {
    Task _updatedTask = task;
    task.taskStatus = status;
    task.doneDate = DateTime.now();
    int index = getTaskIndex(task);
    print('task index: $index');
    await _taskRepository.updateTask(index, task).then((value) {
      if (value == -1) {
        print("Something Wrong");
      } else {
        print("Task updated sucessfully ");
      }
    });
    onInit();
  }

  updateTaskTimer(Task task, int time) async {
    int index = getTaskIndex(task);
    task.SecondTime = time;
    print('task index: $index');
    await _taskRepository.updateTask(index, task).then((value) {
      if (value == -1) {
        print("Something Wrong (Update Timer)");
      } else {
        print("Task Timer updated sucessfully ");
      }
    });
    onInit();
  }

  getCSV() async {
    List<List<dynamic>> rows = [];
    for (int i = 0; i < doneList.length; i++) {
      List<dynamic> row = [];
      row.add(doneList[i].id);
      row.add(doneList[i].name);
      row.add(doneList[i].SecondTime);
      row.add(doneList[i].doneDate);
      row.add(doneList[i].taskStatus);
      rows.add(row);
    }
    String csvData = ListToCsvConverter().convert(rows);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-${DateTime.now()}.csv";
    final File file = File(path);
    await file.writeAsString(csvData);
    OpenFile.open(path);
  }
}
