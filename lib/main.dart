import 'package:expense_management/Data/expense_data.dart';
import 'package:expense_management/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('expense_database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Home(),
      ),
    );
  }
}
