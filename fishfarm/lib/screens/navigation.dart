import 'package:fishfarm/screens/homepage.dart';
import 'package:fishfarm/screens/recommend_fish.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatefulWidget {
  const ButtomNavigation({required Key key}) : super(key: key);

  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(
      key: Key('home'),
      title: 'Home',
    ),
    FishRecommendor(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Data View',
            backgroundColor: Color.fromARGB(255, 70, 40, 205),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recommendor',
            backgroundColor: Color.fromARGB(255, 47, 39, 200),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 15, 9, 65),
        onTap: _onItemTapped,
      ),
    );
  }
}
