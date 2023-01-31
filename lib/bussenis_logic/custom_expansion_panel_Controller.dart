import 'package:abd_todo_app/bussenis_logic/todo_main_page_controller.dart';
import 'package:get/get.dart';
import '../data/task.dart';

class ExpansionPanelController extends GetxController {
  TodoMainPageController _todoMainPageController = Get.find();

  RxBool isExpanded = false.obs;
  RxDouble containeHheight = 0.0.obs;

  Rx<ExpansionPanelType> expansionPanelType = ExpansionPanelType.todo.obs;
  RxList<Task>? tasks = <Task>[].obs;

  init(bool expanded, ExpansionPanelType expansionType, List<Task>? taskList) {
    isExpanded.value = expanded;
    expansionPanelType.value = expansionType;
    tasks?.value = taskList!;
  }

  deleteTaskFromPreviousList(Task task) {
    switch (task.taskStatus!) {
      case TaskStatus.done:
        _todoMainPageController.doneList.remove(task);
        break;
      case TaskStatus.inProgress:
        _todoMainPageController.inProgressList.remove(task);
        break;
      case TaskStatus.todo:
        _todoMainPageController.todoList.remove(task);
        break;
    }
  }

  addTaskToSpecificList(Task task) {
    switch (expansionPanelType.value) {
      case ExpansionPanelType.done:
        task.taskStatus = TaskStatus.done;
        _todoMainPageController.doneList.add(task);
        break;
      case ExpansionPanelType.inProgress:
        task.taskStatus = TaskStatus.inProgress;

        _todoMainPageController.inProgressList.add(task);
        break;
      case ExpansionPanelType.todo:
        task.taskStatus = TaskStatus.todo;
        _todoMainPageController.todoList.add(task);
        break;
    }
    setContainerHight(((tasks?.length)! * 80));
  }

  reflectExpandedValue() {
    isExpanded.value = !isExpanded.value;
  }

  setContainerHight(double hight) {
    containeHheight.value = hight;
  }

  onClickExpand() {
    reflectExpandedValue();
    isExpanded.value && tasks?.length != null
        ? setContainerHight(((tasks?.length)! * 100))
        : setContainerHight(0);
  }
}
