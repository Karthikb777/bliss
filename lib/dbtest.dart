//  this file was used to test the database.

import 'database.dart';
import 'package:flutter/material.dart';

// Note notetest = Note('testnote', 'test');
// var testdb = DBfunc();

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  Future<List<Note>> notes;
  // Future<List<Map<dynamic, dynamic>>> noteMaps;
  var db;

  // Future<List<Notes>> notes;
  @override
  void initState() {
    super.initState();
    db = DBfunc();
    notes = db.getNotes();
  }

  save() {
    setState(
      () {
        // Note notetest = Note('testnote@', 'test2');
        // var res = testdb.saveNote(notetest);
        // testdb.close();
        notes = db.getNotes();
        // print(res);
        // print(res);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: notes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData != null) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Card(
                    color: Colors.grey[850],
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          snapshot.data[index].title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          snapshot.data[index].content,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.star,
                        color: Colors.yellow[300],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.data == null) {
              return Text('loading...');
            }

            if (snapshot.error) {
              print(snapshot.error);
              return snapshot.error;
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          save();
        },
      ),
    );
  }
}
