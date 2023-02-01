import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bussenis_logic/buttom_sheet_controller.dart';

class BottomSheetPage extends StatelessWidget {
  bool isEdit;
  BottomSheetController bottomSheetController;
  BottomSheetPage(
      {Key? key, this.isEdit = false, required this.bottomSheetController})
      : super(key: key);
  // BottomSheetController _bottomSheetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 290,
        color: Colors.amber.withOpacity(0.6),
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Container(
                    height: 3.0, width: 40.0, color: const Color(0xFF32335C))),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Form(
                key: bottomSheetController.formKey.value,
                child: TextFormField(
                  focusNode: bottomSheetController.myFocusNode.value,
                  controller: bottomSheetController.taskNameController.value,
                  validator: (v) => bottomSheetController.nullValidator(v),
                  onTap: () => bottomSheetController.setClickedValueFalse(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Task name',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Task Status :"),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 0,
                          groupValue: bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'Todo',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: bottomSheetController.radioValue.value == 0
                                  ? Colors.black
                                  : null),
                        ),
                        Radio(
                          value: 1,
                          groupValue: bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'In Progress',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: bottomSheetController.radioValue.value == 1
                                  ? Colors.black
                                  : null),
                        ),
                        Radio(
                          value: 2,
                          groupValue: bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: bottomSheetController.radioValue.value == 2
                                  ? Colors.black
                                  : null),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(
                        color: isEdit ? Colors.orange : Colors.green),
                    backgroundColor: bottomSheetController.clicked.value
                        ? isEdit
                            ? Colors.orange
                            : Colors.green
                        : Colors.transparent),
                onPressed: () {
                  bottomSheetController.onClicked(isEdit);
                },
                child: isEdit
                    ? Icon(
                        Icons.edit,
                        color: bottomSheetController.clicked.value
                            ? Colors.white
                            : Colors.orange,
                      )
                    : Icon(
                        Icons.done,
                        color: bottomSheetController.clicked.value
                            ? Colors.white
                            : Colors.green,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
