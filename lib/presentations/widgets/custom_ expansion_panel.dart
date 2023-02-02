import 'package:abd_todo_app/presentations/widgets/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../bussenis_logic/custom_expansion_panel_Controller.dart';
import '../../data/models/task.dart';

class CustomExpansionPanel extends StatefulWidget {
  Color color;
  List<Task>? tasks;
  bool isExpanded;
  String title;
  ExpansionPanelType expansionPanelType;
  Icon icon;

  void Function(Task)? onAccept;
  void Function(Task)? delete;
  void Function(Task)? edit;
  void Function(Task)? onDoneTask;
  void Function()? onExpanded;

  CustomExpansionPanel(
      {Key? key,
      required this.title,
      this.color = Colors.grey,
      this.tasks,
      this.isExpanded = false,
      this.onAccept,
      required this.expansionPanelType,
      this.delete,
      this.edit,
      this.onDoneTask,
      this.onExpanded,
      required this.icon})
      : super(key: key);

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  ExpansionPanelController _expansionPanelController = Get.find();

  /// slidable task widget
  Widget slidableTaskWidget({required Task task}) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () => widget.delete!(task)),
        children: [
          SlidableAction(
            onPressed: (context) => widget.delete!(task),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) => widget.edit!(task),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: TaskWidget(
        task: task,
        onDone: () =>
            widget.onDoneTask != null ? widget.onDoneTask!(task) : null,
      ),
    );
  }

  Widget _buildDraggableItem({
    required Task task,
    required List<Task> tasks,
  }) {
    return LongPressDraggable<Task>(
      data: task,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Container(
        width: 400,
        // height: 30,
        child: TaskWidget(
          task: task,
        ),
      ),
      child: slidableTaskWidget(task: task),
    );
  }

  @override
  void initState() {
    _expansionPanelController.init(
        widget.isExpanded, widget.expansionPanelType, widget.tasks!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      builder: (context, candidateItems, rejectedItems) {
        return Obx(
          () => Column(
            children: [
              ListTile(
                title: Text(widget.title),
                leading: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: widget.icon),
                ),
                trailing: IconButton(
                    onPressed: () {
                      _expansionPanelController.onClickExpand();
                      widget.onExpanded != null ? widget.onExpanded!() : null;
                    },
                    icon: Icon(
                      !_expansionPanelController.isExpanded.value
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      color: widget.color.withOpacity(0.7),
                    )),
                onTap: () => _expansionPanelController.onClickExpand(),
              ),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                height: _expansionPanelController.containeHheight.value,
                duration: const Duration(seconds: 1),
                color: widget.color.withOpacity(0.1),
                child: ListView.builder(
                    itemCount: _expansionPanelController.tasks?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildDraggableItem(
                          task: _expansionPanelController.tasks![index],
                          tasks: _expansionPanelController.tasks!);
                    }),
              ),
              Divider(
                thickness: 5,
                color: Colors.grey.withOpacity(0.2),
              )
            ],
          ),
        );
      },
      onAccept: (item) {
        // _expansionPanelController.deleteTaskFromPreviousList(item);
        // _expansionPanelController.addTaskToSpecificList(item);
        widget.onAccept!(item);
      },
    );
  }
}
