import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'main.dart';
import 'todos.dart';
import 'database.dart';

class NewTodo extends StatefulWidget {
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final title = TextEditingController();
  var db;
  // final todo = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = DBfunc();
    // title.addListener(_printLatestValue);
    // note.addListener(_printLatestValue);
  }

  save(String title) {
    setState(
      () {
        Todo notetest = Todo(title, 'F');
        var res = db.saveTodo(notetest);
        // testdb.close();
        // todos = db.getTodos();
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
    // todo.dispose();
    super.dispose();
  }

  // _printLatestValue() {
  //   print("text field: ${title.text}");
  //   // print("text field: ${todo.text}");
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _printLatestValue();
            save(title.text);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainApp(),
              ),
            );
          },
          backgroundColor: Colors.green[300],
          child: Icon(
            Icons.save,
            color: Colors.grey.shade900,
          ),
        ),
        // backgroundColor: Colors.grey.shade900,
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
                    hintText: 'Todo',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  controller: title,
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
