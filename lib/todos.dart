import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'database.dart';
import 'newTodo.dart';

class Todos extends StatefulWidget {
  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  Future<List<Todo>> todos;
  var db;

  @override
  void initState() {
    super.initState();
    db = DBfunc();
    // print(db.getTodos());
  }

  update(String title, completed) {
    setState(() {
      Todo update = Todo(title, completed);
      var res = db.updateTodo(update);
    });
  }

  delete(String title) {
    setState(() {
      var res = db.deleteTodo(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    todos = db.getTodos();
    return Scaffold(
      // backgroundColor: Colors.grey.shade900,
      backgroundColor: HexColor('#33333d'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed!');
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTodo(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[900],
        ),
        backgroundColor: Colors.green[300],
      ),
      body: FutureBuilder(
          future: todos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 8.0),
                      child: new Card(
                        // color: Colors.grey[800],
                        color: HexColor('#373741'),
                        // elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                var flag;
                                if (snapshot.data[index].completed == 'T') {
                                  flag = 'F';
                                } else if (snapshot.data[index].completed ==
                                    'F') {
                                  flag = 'T';
                                }
                                update(snapshot.data[index].title, flag);
                              },
                              icon: Icon(
                                snapshot.data[index].completed == "T"
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: Colors.green[300],
                              ),
                            ),
                            title: Text(
                              snapshot.data[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration:
                                      snapshot.data[index].completed == "T"
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                              ),
                              onPressed: () {
                                print(1);
                                delete(snapshot.data[index].title);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.data == null) {
              return Text('');
            }
            if (snapshot.error) {
              print(snapshot.error);
              return snapshot.error;
            }
          }),
    );
    // );
  }
}
