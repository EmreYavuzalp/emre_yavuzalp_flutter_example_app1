import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/fluttirci/testJson/db'));

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

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying

  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    var fruit;
    for (int i = 0; i < _WorkShiftStatefulWidgetState.data!.length; i++) {
      fruit = _WorkShiftStatefulWidgetState.data?[i].title;
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    var fruit;
    for (int i = 0; i < _WorkShiftStatefulWidgetState.data!.length; i++) {
      fruit = _WorkShiftStatefulWidgetState.data?[i].title;
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class WorkShift extends StatelessWidget {
  //bu da aşağıdakiyle alakalı.
  //static const String _title = 'Flutter Code Sample';
  const WorkShift({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Work shifts",
            selectionColor: Colors.orange,
          ),
        ),
        body: WorkShiftStatefulWidget(restorationId: 'main'),
      ),
    );
  }
}

class WorkShiftStatefulWidget extends StatefulWidget {
  const WorkShiftStatefulWidget({this.restorationId});

  final String? restorationId;

  @override
  State<WorkShiftStatefulWidget> createState() =>
      _WorkShiftStatefulWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _WorkShiftStatefulWidgetState extends State<WorkShiftStatefulWidget>
    with RestorationMixin {
  late Future<Album> futureAlbum;
  late Future<List<Album>> user;
  static List<Album>? data;
  @override
  void initState() {
    super.initState();

    // Assign that variable your Future.
    user = fetchAlbum();
  }

  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Data selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          OutlinedButton(
            onPressed: () {
              _restorableDatePickerRouteFuture.present();
            },
            child: const Text('Select the date'),
          ),
          Expanded(
            child: FutureBuilder<List<Album>>(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  data = snapshot.data ?? [];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Text(data![index].title),
                      ]);
                    },
                    itemCount: data!.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: Text(
                'These texts are from a web server, they are actually dynamically pulled with flutter http methods.'),
          ),
        ],
      ),
    );
  }
}
