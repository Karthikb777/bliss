import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
import 'database.dart';
// import 'stateProvider.dart';
import 'main.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  Future<List<Note>> notes;
  var db;
  final title = TextEditingController();
  final note = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = DBfunc();
    // title.addListener(_printLatestValue);
    // note.addListener(_printLatestValue);
  }

  save(String title, content) {
    setState(
      () {
        Note new_note = Note(title, content);
        var res = db.saveNote(new_note);
        // testdb.close();
        // notes = db.getNotes();
        // print(res);
        // print(res);
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    title.dispose();
    note.dispose();
    super.dispose();
  }

  // _printLatestValue() {
  //   print("text field: ${title.text}");
  //   print("text field: ${note.text}");
  //   // Provider.of<NoteTodoModel>(context, listen: false)
  //   // .createNote(title: title.text, content: note.text);
  // }

  createnote() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            save(title.text, note.text);
            // Provider.of<NoteTodoModel>(context, listen: false).createNote(
            //     title: title.text.toString(), content: note.text.toString());
            // _printLatestValue();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainApp(),
              ),
            );
            // final nt = Provider.of<NoteTodoModel>(context, listen: false);
          },
          backgroundColor: Colors.green[300],
          child: Icon(
            Icons.save,
            color: Colors.grey.shade900,
          ),
        ),
        backgroundColor: HexColor('#33333d'),
        appBar: AppBar(
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
            },
          ),
          title: Text('New'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  controller: title,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.grey.shade800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  controller: note,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
