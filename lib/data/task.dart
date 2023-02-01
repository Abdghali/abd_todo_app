import 'package:enum_to_string/enum_to_string.dart';

enum TaskStatus { done, inProgress, todo }

enum ExpansionPanelType { todo, inProgress, done }

class Task {
  int? id;
  String? name;
  TaskStatus? taskStatus;
  int SecondTime = 00;
  DateTime? doneDate;

  Task({
    this.id,
    this.name,
    this.taskStatus = TaskStatus.todo,
    this.SecondTime = 00,
    this.doneDate,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    taskStatus = EnumToString.fromString(TaskStatus.values, json['taskStatus']);
    SecondTime = int.parse(json['SecondTime'] ?? 00);
    doneDate = json['doneDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['taskStatus'] = EnumToString.convertToString(this.taskStatus);
    data['SecondTime'] = this.SecondTime;
    data['doneDate'] = this.doneDate;
    return data;
  }
}
