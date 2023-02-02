import 'dart:convert';
import 'dart:io';
import 'package:abd_todo_app/data/models/task.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class LocalDBHelper {
  LocalDBHelper._();

  static final LocalDBHelper localDbHelper = LocalDBHelper._();
  // final _secureStorage = FlutterSecureStorage();
  // var encryprionKey;

  hiveInit() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    await Hive.openBox(
      'tasksBox',
      // encryptionCipher: HiveAesCipher(encryprionKey),
    );
    // await genirateEncryptionKey();
  }

  // genirateEncryptionKey() async {
  //   final encryprionKeys = await _secureStorage.read(key: 'key');
  //   if (encryprionKeys == null) {
  //     final key = Hive.generateSecureKey();
  //     await _secureStorage.write(
  //       key: 'abd_local_db123',
  //       value: base64UrlEncode(key),
  //     );
  //   } else {
  //     final key = await _secureStorage.read(key: 'key');
  //     encryprionKey = base64Url.decode(key!);
  //     print('Encryption key: $encryprionKey');

  //   }
  // }

  Future<int> getListLingth() async {
    return await Hive.box('tasksBox').values.length ?? 0;
  }

  clearBox() {
    Hive.box('tasksBox').clear();
  }

  Future<int> createTask(Task task) async {
    int value = -1;

    try {
      int lingth = await getListLingth();
      Task _task = task;
      _task.id = lingth++;
      await Hive.box('tasksBox').add(_task.toJson()).then((v) => value = v);
    } catch (e) {
      print("Something wrong");
    }

    return value;
  }

  Future<List<Task>> getAllTasks() async {
    List<Task> listOfTasks = [];
    try {
      listOfTasks = await Hive.box('tasksBox')
          .values
          .map((e) => Task.fromJson(e))
          .toList();
      print(await Hive.box('tasksBox').values);
    } catch (e) {
      print("Something wrong");
    }
    return listOfTasks;
  }

  Future<int> deleteTask(int index) async {
    int value = -1;
    try {
      Hive.box('tasksBox').deleteAt(index);
      return 1;
    } catch (e) {
      print("Something wrong....");
    }

    return value;
  }

  Future<int> updateTask(int index, Task task) async {
    int value = -1;
    try {
      print('Task before  ..${task.id} index : ${index}');
      Hive.box('tasksBox').putAt(index, task.toJson());
      return 1;
    } catch (e) {
      print(e);
      print("Something wrong....");
    }

    return value;
  }
}
