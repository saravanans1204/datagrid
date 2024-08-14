// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//import 'package:datagrid/mycustomtable.dart';
import 'package:datagrid/mycustomtable.dart';
import 'package:datagrid/providers/TableState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedTextState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color.fromARGB(255, 233, 104, 94),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: MyCustomTable(),
        ),
      ),
    );
  }
}