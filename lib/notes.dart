import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'database.dart';
import 'viewNote.dart';
import 'newNote.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future<List<Note>> notes;
  // Future<List<Map<dynamic, dynamic>>> noteMaps;
  var db;

  // Future<List<Notes>> notes;
  @override
  void initState() {
    super.initState();
    db = DBfunc();
  }

  // save() {
  //   setState(
  //     () {
  //       // Note notetest = Note('testnote@', 'test2');
  //       // var res = testdb.saveNote(notetest);
  //       // testdb.close();
  //       notes = db.getNotes();
  //       // print(res);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    notes = db.getNotes();
    // setState(() {
    //   notes = db.getNotes();
    // });
    return Scaffold(
      // backgroundColor: Colors.grey.shade900,
      backgroundColor: HexColor('#33333d'),
      floatingActionButton: FloatingActionButton(
        // elevation: 15,
        backgroundColor: Colors.green[300],
        // backgroundColor: HexColor('#2bc998'),
        onPressed: () {
          print('pressed 2');
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNote(),
            ),
          );
          // Provider.of<NoteTodoModel>(context, listen: false)
          //     .createNote(title: 'hi', content: 'hi');
        },
        child: Icon(
          Icons.add,
          color: Colors.grey.shade900,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: notes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewNote(title: snapshot.data[index].title),
                          ),
                        );
                        print(snapshot.data[index]);
                      },
                      child: new Card(
                        // color: Colors.grey[800],
                        color: HexColor('#373741'),
                        // elevation: 10,
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
                          // trailing: Icon(
                          //   Icons.star,
                          //   color: Colors.yellow[300],
                          // ),
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
                return Container();
              }
            }),
      ),
    );
  }
}
