import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController {
  static late Database database;
// step 1 -- initialize db

  static Future<void> initializeDataBase() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }

    database = await openDatabase(
      "employee.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Employee (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
      },
    );
  }

  static Future<void> addEmployee(
      {required String name, required String designation}) async {
    await database.rawInsert(
        'INSERT INTO Employee(name, designation) VALUES(?, ?)',
        [name, designation]);
    await getEmployee();
  }

  static updateEmployee() {}
  static deleteEmployee() {}

  static Future<void> getEmployee() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Employee');
    log(list.toString());
  }
}
