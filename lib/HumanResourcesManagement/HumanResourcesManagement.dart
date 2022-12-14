import 'package:flutter/material.dart';
import '/HumanResourcesManagement/AllowanceRequests.dart';
import 'Allowances.dart';

class HumanResourcesManagement extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Allowances etc.'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(100),
        crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        crossAxisCount: 1,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Click event on Container");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Allowances()));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[500],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Allowances",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Click event on Container");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllowanceRequests()));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[500],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Request an allowance',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
