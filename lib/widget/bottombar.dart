import 'package:flutter/material.dart';
import 'package:sportsblog/screens/HomeScreen.dart';
import 'package:sportsblog/screens/createBlog.dart';
import 'package:sportsblog/screens/searchScreen.dart';

bottombar(int index, context) {
  var color = Colors.black;
  var color2 = Colors.white;
  var bg = Colors.pink;
  var color3 = Colors.black;
  switch (index) {
    case 0:
      color = Colors.purple;
      break;
    case 1:
      color2 = Colors.white;
      bg = Colors.purple;
      break;
    case 2:
      color3 = Colors.purple;
      break;
  }
  return BottomAppBar(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          child: Icon(
            Icons.home,
            color: color,
          ),
        ),
        FloatingActionButton(
          backgroundColor: bg,
          onPressed: () {
            Navigator.of(context).pushNamed(CreateBlog.routeName);
          },
          child: Icon(
            Icons.add,
            color: color2,
            size: 40,
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
          child: Icon(
            Icons.search,
            color: color3,
          ),
        ),
      ],
    ),
  );
  return BottomNavigationBar(
    elevation: 55,
    selectedItemColor: Colors.purple,
    currentIndex: index,
    items: [
      BottomNavigationBarItem(
        icon: FlatButton(
            child: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            }),
        title: Text('home'),
      ),
      BottomNavigationBarItem(
        icon: GestureDetector(
            child: Icon(Icons.add),
            onTap: () => {
                  print('clicked add'),
                  Navigator.of(context).pushNamed(CreateBlog.routeName),
                }),
        title: GestureDetector(
            child: new Text('Create'),
            onTap: () => {
                  print('clicked add'),
                  Navigator.of(context).pushNamed(CreateBlog.routeName),
                }),
      ),
      BottomNavigationBarItem(
          icon: GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              }),
          title: Text('Search'))
    ],
  );
}
