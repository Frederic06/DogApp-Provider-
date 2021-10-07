import 'package:flutter/material.dart';
import 'breed_list.dart';
import 'login.dart';

/// This is the stateful widget that the main application instantiates.
class BottomBarWidget extends StatefulWidget {
  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    LoginWidget(),
    BreedList(),
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'DogApp',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
