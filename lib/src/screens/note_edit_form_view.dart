import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/src/constants/strings_constants.dart';
import 'package:notes/src/controllers/form_controller.dart';
import 'package:notes/src/models/note_model.dart';

class NoteEditFormView extends StatelessWidget {
  final FormController formControllers = FormController();
  final Note note;

  NoteEditFormView({Key? key, required this.note}) {
    formControllers.titleController.text = note.title;
    formControllers.textBodyController.text = note.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsConstants.editingNoteTitle),
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
        onPressed: () => _editNote(context),
        label: Text(
          StringsConstants.fabSaveNote,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _editNote(BuildContext context) {
    final newNote = Note(
        id: note.id,
        title: formControllers.titleController.text,
        body: formControllers.textBodyController.text,
        time: DateFormat.Hm().format(
          DateTime.now(),
        ));
    Navigator.pop(context, newNote);
  }
}
