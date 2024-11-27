import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController {
  static late Database database;

  static List<Map> employeesList = [];
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

  static Future updateEmployee(
      {required String name,
      required String designation,
      required int id}) async {
    await database.rawUpdate(
        'UPDATE Employee SET name = ?, designation = ? WHERE id = ?',
        [name, designation, id]);

    await getEmployee();
  }

  static Future<void> deleteEmployee(int id) async {
    await database.rawDelete('DELETE FROM Employee WHERE id = ?', [id]);
    await getEmployee();
  }

  static Future<void> getEmployee() async {
    employeesList = await database.rawQuery('SELECT * FROM Employee');
    log(employeesList.toString());
  }
}
