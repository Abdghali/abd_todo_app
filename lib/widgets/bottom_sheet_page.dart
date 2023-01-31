import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bussenis_logic/buttom_sheet_controller.dart';

class BottomSheetPage extends StatelessWidget {
  BottomSheetPage({Key? key}) : super(key: key);
  BottomSheetController _bottomSheetController = Get.find();

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
                key: _bottomSheetController.formKey.value,
                child: TextFormField(
                  focusNode: _bottomSheetController.myFocusNode.value,
                  controller: _bottomSheetController.taskNameController.value,
                  validator: (v) => _bottomSheetController.nullValidator(v),
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
                          groupValue: _bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            _bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'Todo',
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  _bottomSheetController.radioValue.value == 0
                                      ? Colors.black
                                      : null),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            _bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'In Progress',
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  _bottomSheetController.radioValue.value == 1
                                      ? Colors.black
                                      : null),
                        ),
                        Radio(
                          value: 2,
                          groupValue: _bottomSheetController.radioValue.value,
                          onChanged: (value) {
                            _bottomSheetController.radioValue.value = value!;
                          },
                        ),
                        Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  _bottomSheetController.radioValue.value == 2
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
                    side: const BorderSide(color: Colors.green),
                    backgroundColor: _bottomSheetController.clicked.value
                        ? Colors.green
                        : Colors.transparent),
                onPressed: () {
                  _bottomSheetController.onClicked();
                },
                child: Icon(
                  Icons.done,
                  color: _bottomSheetController.clicked.value
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
