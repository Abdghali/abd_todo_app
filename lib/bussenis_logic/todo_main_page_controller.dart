import 'package:abd_todo_app/data/Repository/task_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
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
}
