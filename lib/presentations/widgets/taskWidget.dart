import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../bussenis_logic/taskWidgetController.dart';
import '../../data/models/task.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  void Function()? onDone;
  TaskWidget({Key? key, required this.task, this.onDone}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskWidgetController _taskWidgetController = Get.find();

  @override
  void initState() {
    super.initState();
    _taskWidgetController.init(widget.task);
  }

  _timerWidget() {
    return StreamBuilder<int>(
      stream: _taskWidgetController.stopWatchTimer.value.rawTime,
      initialData: _taskWidgetController.stopWatchTimer.value.rawTime.value,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(value!,
            hours: _taskWidgetController.isHours.value);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            displayTime,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold,
                color: Colors.blue.withOpacity(0.7)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        // height: 50,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(() => ListTile(
              title: Text(
                _taskWidgetController.task.value.name!,
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: _timerWidget(),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: _taskWidgetController.onPause,
                        icon: Icon(_taskWidgetController.isPause.value
                            ? Icons.pause_outlined
                            : Icons.play_arrow)),
                    IconButton(
                        onPressed: widget.onDone, icon: const Icon(Icons.done)),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
