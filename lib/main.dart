import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'bindings/app_bindings.dart';
import 'data/services/local_db_helper.dart';
import 'presentations/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDBHelper.localDbHelper.hiveInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: AppBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
