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
    for (int i = 0; i < _SomeRandomButtonTwoState.data!.length; i++) {
      fruit = _SomeRandomButtonTwoState.data?[i].title;
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
    for (int i = 0; i < _SomeRandomButtonTwoState.data!.length; i++) {
      fruit = _SomeRandomButtonTwoState.data?[i].title;
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

class SomeRandomButtonTwo extends StatefulWidget {
  const SomeRandomButtonTwo({Key? key}) : super(key: key);

  @override
  State<SomeRandomButtonTwo> createState() => _SomeRandomButtonTwoState();
}

class _SomeRandomButtonTwoState extends State<SomeRandomButtonTwo> {
  late Future<Album> futureAlbum;
  late Future<List<Album>> user;
  static List<Album>? data;
  @override
  void initState() {
    super.initState();

    // Assign that variable your Future.
    user = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Some random button 2'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Accepted',
                ),
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Rejected',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
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
                        return Center(child: const CircularProgressIndicator());
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                        'These texts are from a web server, they are actually dynamically pulled with flutter http methods.'),
                  ),
                ],
              ),
              Column(
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
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                        'These texts are from a web server, they are actually dynamically pulled with flutter http methods.'),
                  ),
                ],
              ),
              Column(
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
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                        'These texts are from a web server, they are actually dynamically pulled with flutter http methods.'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
