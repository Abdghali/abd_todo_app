import 'package:abd_todo_app/data/models/task.dart';

import '../services/local_db_helper.dart';

class TaskRepository {
  Future<List<Task>> getAllTasks() async {
    return await LocalDBHelper.localDbHelper.getAllTasks();
  }

  Future<int> createTask(Task task) async {
    return await LocalDBHelper.localDbHelper.createTask(task);
  }

  clearBox() async {
    await LocalDBHelper.localDbHelper.clearBox();
  }

  Future<int> getTaskListLingth() async {
    return await LocalDBHelper.localDbHelper.getListLingth();
  }

  Future<int> deleteTask(int index) async {
    return await LocalDBHelper.localDbHelper.deleteTask(index);
  }

  Future<int> updateTask(int index, Task task) async {
    return await LocalDBHelper.localDbHelper.updateTask(index, task);
  }
}
