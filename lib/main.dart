import 'package:flutter/material.dart';
import '/HumanResourcesManagement/AllowanceRequests.dart';
import '/HumanResourcesManagement/Allowances.dart';
import '/HumanResourcesManagement/HumanResourcesManagement.dart';
import '/login.dart';
import '/register.dart';
import '/HomePage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      /* light theme settings */
    ),
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'HomePage': (context) => HomePage(),
    },
  ));
}
