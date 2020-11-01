// this is the all the database fuctionality related to this app.

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'path';

class Note {
  String title, content;
  Note(this.title, this.content);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'content': content,
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    content = map['content'];
  }
}

class Todo {
  String title;
  String completed;

  Todo(this.title, this.completed);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'completed': completed,
    };
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    completed = map['completed'];
  }
}

class DBfunc {
  static Database _db;

  static const startupTitle = 'Bliss, a simple note taking/todo app.';
  static const startupContent =
      'You can create, edit and delete notes. You can create, mark as fulfilled/not fulfilled and delete todos. This app is offline and all the notes and todos are stored in an sqlite database. Press the + button below to create a note!';

  static const String NOTE_TITLE = 'title';
  static const String NOTE_CONTENT = 'content';
  static const String NOTE_TABLE = 'note';

  static const String TODO_TITLE = 'title';
  static const String TODO_COMPLETED = 'todoCompleted';
  static const String TODO_TABLE = 'todo';
  // static const String DB_TODO = 'todo.db';
  static const String DB = 'noteTodo.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE note (title TEXT, content TEXT)");
    await db.execute("CREATE TABLE todo (title TEXT, completed TEXT)");
    await db.execute("INSERT INTO note (title, content) values (?, ?)",
        [startupTitle, startupContent]);

    // await db.execute(
    //     "CREATE TABLE $TODO_TABLE ($TODO_TITLE TEXT PRIMARY KEY, $TODO_COMPLETED INTEGER)");
  }

  Future<Note> saveNote(Note note) async {
    var dbClient = await db;
    var title = note.title;
    var content = note.content;
    // var noteInserted = await dbClient.insert(NOTE_TABLE, note.toMap());
    await dbClient.execute(
        "INSERT INTO note (title, content) values (?, ?)", [title, content]);
    return note;
  }

  Future<Todo> saveTodo(Todo todo) async {
    var dbClient = await db;
    var completed = todo.completed == 'T' ? 'T' : 'F';
    print(completed);
    // implement save functionality here
    await dbClient.execute("INSERT INTO todo (title, completed) values (?, ?)",
        [todo.title, completed]);
    // var todoInserted = await dbClient.insert(TODO_TABLE, todo.toMap());
    return todo;
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    // List<Map> noteMaps =
    // await dbClient.query(NOTE_TABLE, columns: [NOTE_TITLE, NOTE_CONTENT]);
    List<Map> noteMaps = await dbClient.rawQuery("SELECT * FROM note");
    // print(noteMaps);
    noteMaps = noteMaps.reversed.toList();
    List<Note> notes = [];
    if (noteMaps.length > 0) {
      for (int i = 0; i < noteMaps.length; i++) {
        await notes.add(
          Note.fromMap(noteMaps[i]),
        );
      }
    }
    // viewNote('testnote');
    return notes;
  }

  Future<List<Todo>> getTodos() async {
    var dbClient = await db;
    // List<Map> noteMaps =
    // await dbClient.query(NOTE_TABLE, columns: [NOTE_TITLE, NOTE_CONTENT]);
    List<Map> todoMaps = await dbClient.rawQuery("SELECT * FROM todo");
    // print(todoMaps.length);
    todoMaps = todoMaps.reversed.toList();
    List<Todo> todos = [];
    if (todoMaps.length > 0) {
      for (int i = 0; i < todoMaps.length; i++) {
        // print(todoMaps[i]['completed']);
        await todos.add(
          Todo.fromMap(todoMaps[i]),
          // Todo(todoMaps[i]['title'], todoMaps[i]['completed']),
        );
      }
    }
    // viewNote('testnote');
    print(todos);
    return todos;
  }

// Future<List<Note>>
  Future<Note> viewNote(String title) async {
    var dbClient = await db;
    var sel =
        await dbClient.rawQuery('SELECT * FROM note WHERE title = "$title"');
    print(sel);
    var note = Note.fromMap(sel[0]); // List<Note> note = [];
    // if (sel.length > 0) {
    //   for (int i = 0; i < sel.length; i++) {
    //     await note.add(
    //       Note.fromMap(sel[i]),
    //     );
    //   }
    // }
    return note;
  }

  // Future<List<Todo>> getTodos() async {
  //   var dbClient = await db;
  //   List<Map> todoMaps =
  //       await dbClient.query(TODO_TABLE, columns: ["title", "completed"]);
  //   List<Todo> todos = [];
  //   if (todoMaps.length > 0) {
  //     for (int i = 0; i < todoMaps.length; i++) {
  //       todos.add(
  //         Todo.fromMap(todoMaps[i]),
  //       );
  //     }
  //   }
  //   return todos;
  // }

  Future<int> deleteNote(String title) async {
    var dbClient = await db;
    return await dbClient
        .delete(NOTE_TABLE, where: "$NOTE_TITLE = ?", whereArgs: [title]);
  }

  Future<int> deleteTodo(String title) async {
    var dbClient = await db;
    return await dbClient
        .delete(TODO_TABLE, where: "$TODO_TITLE = ?", whereArgs: [title]);
  }

  Future<int> updateNote(Note note, String search) async {
    var dbClient = await db;
    print(note.title);
    return dbClient.update(NOTE_TABLE, note.toMap(),
        where: "$NOTE_TITLE = ?", whereArgs: [search]);
  }

  Future<int> updateTodo(Todo todo) async {
    var dbClient = await db;
    return dbClient.update(TODO_TABLE, todo.toMap(),
        where: "$TODO_TITLE = ?", whereArgs: [todo.title]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
