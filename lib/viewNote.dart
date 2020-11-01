import 'package:bliss/newNote.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'database.dart';
import 'main.dart';
import 'editNote.dart';

class ViewNote extends StatefulWidget {
  String title;
  ViewNote({@required this.title});
  @override
  _ViewNoteState createState() => _ViewNoteState(title: title);
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  var db;
  // Future<List<Note>> note;
  Future<Note> note;
  String noteTitle, noteContent;

  _ViewNoteState({@required this.title});

  @override
  void initState() {
    super.initState();
    noteTitle;
    noteContent;
    db = DBfunc();
    note = db.viewNote(title);
  }

  // noteContents(String title, content) {
  //   setState(() {
  //     noteTitle = title;
  //     noteContent = content;
  //   });
  // }

  deleteNote() {
    db.deleteNote(title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.grey.shade900,
        backgroundColor: HexColor('#33333d'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // edit();
            print('edit');
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditNote(noteTitle: noteTitle, noteContent: noteContent),
              ),
            );
          },
          backgroundColor: Colors.green[300],
          child: Icon(
            Icons.edit,
            color: Colors.grey.shade900,
          ),
        ),
        appBar: AppBar(
          // backgroundColor: Colors.grey[900],
          backgroundColor: HexColor('#33333d'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainApp(),
                ),
              );
              print(1);
            },
          ),
          title: Text(title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: IconButton(
                onPressed: () {
                  // print('hi');
                  deleteNote();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainApp(),
                    ),
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: note,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              // noteContents(snapshot.data.title, snapshot.data.content);
              noteTitle = snapshot.data.title;
              noteContent = snapshot.data.content;
              return ListView.builder(
                // itemCount: snapshot.data.length,
                itemCount: 1,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Card(
                    color: HexColor('#33333d'),
                    elevation: 0,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          // snapshot.data.title,
                          noteTitle,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          // snapshot.data.content,
                          noteContent,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      // trailing: Icon(
                      //   Icons.star,
                      //   color: Colors.yellow[300],
                      // ),
                    ),
                  );
                },
              );
              // noteContents(snapshot.data.title, snapshot.data.content);
            } else if (snapshot.data == null) {
              return Text('loading...');
            }

            if (snapshot.error) {
              print(snapshot.error);
              return snapshot.error;
            }
          },
        ),
      ),
    );
  }
}
