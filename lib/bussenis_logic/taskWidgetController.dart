import 'package:abd_todo_app/bussenis_logic/todo_main_page_controller.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../data/models/task.dart';

class TaskWidgetController extends GetxController {
  TodoMainPageController _todoMainPageController = Get.find();

  Rx<Task> task = Task().obs;
  RxBool isPause = false.obs;
  RxBool isHours = true.obs;

  final Rx<StopWatchTimer> stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp).obs;
  reflexIsPauseValue() {
    isPause.value = !isPause.value;
  }

  onPause() async {
    !isPause.value
        ? stopWatchTimer.value.onExecute.add(StopWatchExecute.start)
        : stopWatchTimer.value.onStopTimer();
    reflexIsPauseValue();

    !isPause.value
        ? await _todoMainPageController.updateTaskTimer(
            task.value, stopWatchTimer.value.secondTime.value)
        : null;

    print("onPause ${isPause.value}");
    print(stopWatchTimer.value.secondTime.value);
  }

  // onDoneTask() {
  //   if (_todoMainPageController.todoList.value.remove(task.value)) {
  //     _todoMainPageController.todoList.value.remove(task.value);
  //   }
  //   if (_todoMainPageController.inProgressList.value.remove(task.value)) {
  //     _todoMainPageController.inProgressList.value.remove(task.value);
  //   }

  //   /// Todo : detete task from inProgress list and Todo list and add it to Done list.
  //   print('onDoneTask');
  //   print(stopWatchTimer.value.rawTime.value);
  // }

  init(Task? myTask) {
    task.value = myTask!;
    stopWatchTimer.value.setPresetSecondTime(myTask.SecondTime.toInt());
  }
}
