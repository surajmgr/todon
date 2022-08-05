import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todon/models/note.dart';

class DatabaseHelper {
  static final _databasename = "notes.db";
  static final _databaseversion = 1;

  static final table = "my_table";

  static final columnID = 'id';
  static final columnState = 'state';
  static final columnTitle = 'title';
  static final columnDescrption = 'description';
  static final columnDate = 'dateCreated';

  static Database? _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    _database ??= await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnState TEXT,
        $columnTitle TEXT,
        $columnDescrption TEXT,
        $columnDate TEXT
      )
      ''');
  }

  //Custom Functions

  // Future<List<Map<String, dynamic>>>?
  getNoteMapList() async {
    Database? db = await this.database;
    var result = await db?.rawQuery(
        'SELECT * FROM $table order by FIELD($columnState, "In-Progress", "Completed")');
    return result;
  }

  Future<int?> insertNote(Note note) async {
    Database? db = await this.database;
    var result = await db?.insert(table, note.toMap());
    return result;
  }

  Future<int?> updateNote(Note note) async {
    Database? db = await this.database;
    var result = await db?.update(table, note.toMap(),
        where: '$columnID=?', whereArgs: [note.id]);
    return result;
  }

  Future<int?> deleteNote(int id) async {
    Database? db = await this.database;
    var result = await db?.rawDelete('DELETE FROM $table WHERE $columnID=$id');
    return result;
  }

  Future<int?> getCount() async {
    Database? db = await this.database;
    final List<Map<String, dynamic?>>? x =
        await db?.rawQuery('SELECT COUNT (*) from $table');
    int? result = Sqflite.firstIntValue(x!);
    return result;
  }

  Future<List<Note>>? getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = <Note>[];
    for (var i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
