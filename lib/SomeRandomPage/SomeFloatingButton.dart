import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> list2 = _SomeFloatingButtonState.data2;
Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/fluttirci/testJson/db'));
  //this was for testing.
  print(response);
  Map<String, dynamic> userMap = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return (userMap['employees'] as List)
        .map((e) => Album.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album(this.userId, this.id, this.title);

  Album.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
      };
}

void main() => runApp(const SomeFloatingButton());

class SomeFloatingButton extends StatefulWidget {
  const SomeFloatingButton({super.key});

  @override
  State<SomeFloatingButton> createState() => _SomeFloatingButtonState();
}

class _SomeFloatingButtonState extends State<SomeFloatingButton> {
  double _currentSliderValue = 20;

  late Future<Album> futureAlbum;
  late Future<List<Album>> user;
  late List<Album> data;
  static List<String> data2 = [];

  @override
  void initState() {
    super.initState();
    user = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some random page'),
      ),
      body: FutureBuilder<List<Album>>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data ?? [];
            data2.clear();
            for (var element in data) {
              data2.add(element.title);
            }
            return Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: AddCustomerDropDownButtonApp(),
                ),
                const Expanded(
                  flex: 1,
                  child: PotentialNameDropdownButtonApp(),
                ),
                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 5,
                  activeColor: Colors.red,
                  inactiveColor: Colors.purple,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                const Expanded(
                  child: Text('Some slider etc.'),
                ),
                const Expanded(
                  child: Text('dropdowns etc.'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      print('data2 was fetched: ${data2[index]}');
                      return Column(
                        children: [
                          Text(data[index].title),
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              '${snapshot.error}',
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

///////////
///
///Burası müşteri ekle yazan kısım.
class AddCustomerDropDownButtonApp extends StatelessWidget {
  const AddCustomerDropDownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AddCustomerDropdownButton(),
        ],
      ),
    );
  }
}

class AddCustomerDropdownButton extends StatefulWidget {
  const AddCustomerDropdownButton({super.key});

  @override
  State<AddCustomerDropdownButton> createState() =>
      _AddCustomerDropdownButtonState();
}

class _AddCustomerDropdownButtonState extends State<AddCustomerDropdownButton> {
  String? dropdownValue = _SomeFloatingButtonState.data2.isNotEmpty
      ? _SomeFloatingButtonState.data2.first
      : null;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'some dropdown 2',
      ),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: _SomeFloatingButtonState.data2
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//////////
///
///
///Burası potansiyel isim ekle yazan kısım.
class PotentialNameDropdownButtonApp extends StatelessWidget {
  const PotentialNameDropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          PotentialNameDropdownButton(),
        ],
      ),
    );
  }
}

class PotentialNameDropdownButton extends StatefulWidget {
  const PotentialNameDropdownButton({super.key});

  @override
  State<PotentialNameDropdownButton> createState() =>
      _PotentialNameDropdownButtonState();
}

class _PotentialNameDropdownButtonState
    extends State<PotentialNameDropdownButton> {
  String? dropdownValue = _SomeFloatingButtonState.data2.isNotEmpty
      ? _SomeFloatingButtonState.data2.first
      : null;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Some dropdown',
      ),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: _SomeFloatingButtonState.data2
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
