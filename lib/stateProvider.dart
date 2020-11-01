// this file won't be used because there is no global state implemented.
//  The database is directly accessed in different parts of the app.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Note {
  String title, content;
  Note(this.title, this.content);
}

class Todo {
  String title, content;
  bool completed;
  Todo({this.title, this.content, this.completed});
}

class NoteTodoModel extends ChangeNotifier {
  List<Note> notes = [
    Note('test', 'test'),
    // Note('test', 'test'),
    // Note('test', 'test'),
    // Note('test', 'test'),
    // Note('test', 'test'),
  ];
  List<Todo> todos = [];

  List<Note> get getNote => notes;
  List<Todo> get getTodo => todos;

  void createNote({title, content}) {
    Note newNote = Note(title, content);
    print(newNote);
    notes.add(newNote);
    print(notes);
    notifyListeners();
  }

  void createTodo({title, content}) {
    Todo newTodo = Todo(title: title, content: content, completed: false);
    todos.add(newTodo);
    notifyListeners();
  }
}
