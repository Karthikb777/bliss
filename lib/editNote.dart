import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'database.dart';
import 'main.dart';

class EditNote extends StatefulWidget {
  String noteTitle, noteContent;
  EditNote({@required this.noteTitle, @required this.noteContent});
  @override
  _EditNoteState createState() =>
      _EditNoteState(noteTitle: noteTitle, noteContent: noteContent);
}

class _EditNoteState extends State<EditNote> {
  String noteTitle, noteContent;
  _EditNoteState({@required this.noteTitle, @required this.noteContent});

  Future<List<Note>> notes;
  var db;
  var edit_note, search;
  final TextEditingController title = TextEditingController();
  final TextEditingController note = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = DBfunc();
    title.text = noteTitle;
    search = noteTitle;
    note.text = noteContent;
  }

  save(String title, content) {
    setState(
      () {
        Note edited_note = Note(title, content);
        var res = db.updateNote(edited_note, search);
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
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
          title: Text('Edit'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  // keyboardType: TextInputType.multiline,
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
