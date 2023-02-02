import 'package:abd_todo_app/bussenis_logic/todo_main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../data/Repository/task_repo.dart';
import '../data/models/task.dart';
import 'base_controller.dart';

class BottomSheetController extends BaseController {
  RxBool clicked = false.obs;

  RxInt radioValue = 0.obs;

  Rx<TextEditingController> taskNameController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>().obs;
  Rx<FocusNode> myFocusNode = FocusNode().obs;

  Rx<Task> updatedTask = Task().obs;

  setClickedValueTrue() {
    clicked.value = true;
  }

  setClickedValueFalse() {
    clicked.value = false;
  }

  clearTaskName() {
    taskNameController.value.clear();
  }

  setDefultTaskType() {
    radioValue.value = 0;
  }

  clear() {
    clearTaskName();
    setDefultTaskType();
  }

  TaskRepository _taskRepository = TaskRepository();
  TodoMainPageController _todoMainPageController = Get.find();

  createTask(Task task) async {
    await _taskRepository.createTask(task).then((value) {
      if (value == -1) {
        print("Something Wrong");
      } else {
        print("Task created sucessfully ");
      }
    });
    _todoMainPageController.onInit();
  }

  updateTask(Task task) async {
    Task _updatedTask = task;
    _updatedTask.name = taskNameController.value.text;
    _updatedTask.taskStatus = getTaskStatus();
    int index = _todoMainPageController.getTaskIndex(task);
    print('task index: $index');
    await _taskRepository.updateTask(index, task).then((value) {
      if (value == -1) {
        print("Something Wrong");
      } else {
        print("Task updated sucessfully ");
      }
    });
    _todoMainPageController.onInit();
  }

  onClicked(bool isEdit) {
    if (formKey.value.currentState!.validate()) {
      myFocusNode.value.nextFocus();
      TaskStatus _taskStatus = getTaskStatus();
      isEdit
          ? updateTask(updatedTask.value)
          : createTask(Task(
              name: taskNameController.value.text,
              taskStatus: _taskStatus,
            ));

      setClickedValueTrue();
      clearTaskName();
    }
  }

  nullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter task name please';
    } else {
      return null;
    }
  }

  TaskStatus getTaskStatus() {
    switch (radioValue.value) {
      case 0:
        return TaskStatus.todo;
      case 1:
        return TaskStatus.inProgress;

      case 2:
        return TaskStatus.done;
      default:
        return TaskStatus.todo;
    }
  }
}
