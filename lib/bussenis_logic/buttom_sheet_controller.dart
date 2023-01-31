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

  onClicked() {
    if (formKey.value.currentState!.validate()) {
      myFocusNode.value.nextFocus();

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
