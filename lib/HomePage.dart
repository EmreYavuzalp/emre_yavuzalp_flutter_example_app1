import 'package:flutter/material.dart';
import 'package:vodafoneasy/SomeRandomPage/SomeRandomPage.dart';

import '/HumanResourcesManagement/HumanResourcesManagement.dart';

import '/WorkShifts/WorkShift.dart';
import '/WeatherForecast/WeatherForecast.dart';

class HomePage extends StatelessWidget {
  final String recordName;
  final String email;
  final String? password;
  const HomePage(
      {super.key,
      this.email = 'test',
      this.password,
      this.recordName = 'test'});
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
      ),
      home: HomePageStatefulWidget(),
    );
  }
}

class HomePageStatefulWidget extends StatefulWidget {
  const HomePageStatefulWidget({super.key});

  @override
  State<HomePageStatefulWidget> createState() => _HomePageStatefulWidgetState();
}

class Squares extends StatelessWidget {
  const Squares({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Image(
                    /* width: 100,
                    height: 100, */
                    //böyle şeyler yapılabilir gerekirse.
                    image: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                  ),
                  title: Text('Emre Yavuzalp'),
                  subtitle: Text(
                      'Freelance Software Developer \nComputer Engineer&Science'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.cloud),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const WeatherForecast()));
                          //organizasyon yönetimi içindeki şirket dosyaları içine gidiyor.
                        },
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.home),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HumanResourcesManagement()));
                        },
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.work),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkShift()));
                        },
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.abc),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SomeRandomPage()));
                        },
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(25),
              //bu sayı önceden 10 du, 50 yaptım şimdiki görüntü oldu.
              //artırıp azaltınca bu kareler küçülüyor.
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print("Click event on Container");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherForecast()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      "Türkiye Weather Forecast",
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
                            builder: (context) => HumanResourcesManagement()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      'Allowances',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Click event on Container");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WorkShift()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      'Work Shifts',
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
                            builder: (context) => SomeRandomPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      'Some random page',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePageStatefulWidgetState extends State<HomePageStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Squares(),
    Column(
      children: <Widget>[
        Text('test22'),
      ],
    ),
    Column(
      children: <Widget>[
        Text('test33'),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emre\'s random app'),
        leading: Icon(Icons.on_device_training_rounded),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.amber,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
