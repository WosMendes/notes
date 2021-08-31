import 'package:flutter/cupertino.dart';
import 'package:notes/src/database/database_notes.dart';
import 'package:notes/src/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider extends ChangeNotifier {
  addNewNote(Note note) async {
    final Database db = await DatabaseNotes.db.getDatabase();
    db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  removeNote(int? id) async {
    final Database db = await DatabaseNotes.db.getDatabase();
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  updateNote(Note note) async {
    final Database db = await DatabaseNotes.db.getDatabase();
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    print(db.query('notes'));
    notifyListeners();
  }
}
