import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/src/constants/strings_constants.dart';
import 'package:notes/src/controllers/form_controller.dart';
import 'package:notes/src/models/note_model.dart';

class NoteFormView extends StatelessWidget {
  NoteFormView({Key? key}) : super(key: key);

  final FormController formControllers = FormController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsConstants.newNoteTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: formControllers.titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringsConstants.newNoteHintTextTitle,
                ),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: TextField(
                  controller: formControllers.textBodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringsConstants.newNoteHintTextBody,
                  ),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewNote(context),
        label: Text(
          StringsConstants.fabSaveNote,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _createNewNote(BuildContext context) {
    final String noteTitle = formControllers.titleController.text;
    final String noteTextBody = formControllers.textBodyController.text;
    final String noteCreateTime = DateFormat.Hm().format(DateTime.now());
    final newNote = Note(
      title: noteTitle,
      body: noteTextBody,
      time: noteCreateTime,
    );
    Navigator.pop(context, newNote);
  }
}
