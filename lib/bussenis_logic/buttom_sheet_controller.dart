import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'base_controller.dart';

class BottomSheetController extends BaseController {
  RxBool clicked = false.obs;

  RxInt radioValue = 0.obs;

  Rx<TextEditingController> taskNameController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>().obs;
  Rx<FocusNode> myFocusNode = FocusNode().obs;

  setClickedValueTrue() {
    clicked.value = true;
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

  createTask() {
    //Todo store task on db
    print('create task ');
  }

  updateTask() {
    //Todo update task on db
    print('update task ');
  }

  onClicked(bool isEdit) {
    if (formKey.value.currentState!.validate()) {
      myFocusNode.value.nextFocus();
      isEdit ? updateTask() : createTask();

      ///
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
}
