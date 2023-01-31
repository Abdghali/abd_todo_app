import 'package:get/get.dart';

import '../bussenis_logic/buttom_sheet_controller.dart';
import '../bussenis_logic/custom_expansion_panel_Controller.dart';
import '../bussenis_logic/taskWidgetController.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<TaskWidgetController>(() =>
        TaskWidgetController()); // different instances for different list items
    Get.create<ExpansionPanelController>(() =>
        ExpansionPanelController()); // different instances for different list items

    Get.create<BottomSheetController>(() => BottomSheetController());
  }
}
