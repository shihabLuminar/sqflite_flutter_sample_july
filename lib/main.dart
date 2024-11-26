import 'package:flutter/material.dart';
import 'package:sqflite_flutter_sample/controller/home_screen_controller.dart';
import 'package:sqflite_flutter_sample/view/home_screen/home_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeScreenController.initializeDataBase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
