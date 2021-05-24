import 'package:sportsblog/widget/bottombar.dart';

import '../providers/blog.dart';
import '../screens/searchScreen.dart';
import 'package:provider/provider.dart';
import 'createBlog.dart';
import '../widget/homeCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<Blogs>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            height: 0.0,
            width: 0.0,
          ),
          backgroundColor: Colors.transparent,
          title: IconButton(
            iconSize: 100,
            icon: Image.asset(
              'assets/home.png',
            ),
            onPressed: () {},
          ),
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[300],
          child: FutureBuilder(
              future: Provider.of<Blogs>(context).addValue(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return HomeCard();
                }
              }),
        ),
        bottomNavigationBar: bottombar(0, context));
  }
}
