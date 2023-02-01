import 'package:get/get.dart';

import '../bussenis_logic/buttom_sheet_controller.dart';
import '../bussenis_logic/custom_expansion_panel_Controller.dart';
import '../bussenis_logic/taskWidgetController.dart';
import '../bussenis_logic/todo_main_page_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    TodoMainPageController _todoMainPageController =
        Get.put(TodoMainPageController(), permanent: true);
    Get.create<TaskWidgetController>(() =>
        TaskWidgetController()); // different instances for different list items
    Get.create<ExpansionPanelController>(() =>
        ExpansionPanelController()); // different instances for different list items

    Get.create<BottomSheetController>(() => BottomSheetController());
  }
}
