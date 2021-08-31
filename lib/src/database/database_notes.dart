import 'package:notes/src/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseNotes {
  DatabaseNotes._();

  static final DatabaseNotes db = DatabaseNotes._();

  Future<Database> getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'note_app_3.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT,
            time TEXT
          )
          ''');
    }, version: 1);
  }

  Future<List<Note>> getNotes() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('notes');
    final List<Note> notes = [];

    for (Map<String, dynamic> row in result) {
      final Note note = Note(
        id: row['id'],
        title: row['title'],
        body: row['body'],
        time: row['time'],
      );
      notes.add(note);
    }
    return notes;
  }
}
