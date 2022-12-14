import 'package:flutter/material.dart';
import '/SomeRandomPage/SomeRandomButton.dart';
import '/SomeRandomPage/SomeRandomButtonTwo.dart';

class SomeRandomPage extends StatelessWidget {
  const SomeRandomPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Some random page'),
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
                  MaterialPageRoute(builder: (context) => SomeRandomButton()));
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
                "Some random button",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Click event on Container");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SomeRandomButtonTwo()));
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
                'Some random button 2',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
