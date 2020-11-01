import 'package:flutter/material.dart';
import 'package:bliss/todos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'notes.dart';
import 'package:hexcolor/hexcolor.dart';

// this is the root of this app.

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var db;

  @override
  void initState() {
    super.initState();
  }

  _launchURL() {
    const url = 'https://github.com/Karthikb777/bliss';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    // if (about == 0) {
    return MaterialApp(
      // home: Notes(),
      // home: test(),
      // theme: Theme.of(Colors.yellow[300]),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawerScrimColor: Colors.blue[300],
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Bliss'),
            ),
            // backgroundColor: Colors.grey[900],
            backgroundColor: HexColor('#33333d'),
            actions: [
              PopupMenuButton(
                color: HexColor('#373741'),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "About",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onSelected: (value) {
                  _launchURL();
                },
              ),
            ],
            bottom: TabBar(
              // controller: _tabController,
              tabs: [
                Tab(text: 'Notes'),
                Tab(text: 'Todos'),
                // Tab(text: 'About'),
              ],
              indicatorColor: Colors.green[300],
            ),
          ),
          body: TabBarView(
            children: [
              Notes(),
              Todos(),
            ],
          ),
        ),
      ),
    );
  }
}
