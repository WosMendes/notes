import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/src/components/card_note.dart';
import 'package:notes/src/components/change_theme_button.dart';
import 'package:notes/src/constants/strings_constants.dart';
import 'package:notes/src/database/database_notes.dart';
import 'package:notes/src/models/note_model.dart';
import 'package:notes/src/providers/note_provider.dart';
import 'package:notes/src/screens/note_edit_form_view.dart';
import 'package:notes/src/screens/note_form_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  getNotes() async {
    final notes = await DatabaseNotes.db.getNotes();
    return notes;
  }

  List<Note> selectedNotes = [];
  bool isSelectModeActive = false;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: isSelectModeActive
            ? Text(selectedNotes.length.toString())
            : Text(StringsConstants.appName),
        actions: [
          ChangeThemeButton(),
        ],
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          late List<Note> notes;
          if (noteData.hasData) {
            notes = noteData.data as List<Note>;
          } else {
            notes = [];
          }
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (notes.length == 0) {
                return Center(
                  child: Text(
                    StringsConstants.noNotes,
                  ),
                );
              } else {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (isSelectModeActive) {
                          _selectAndDeselectNotes(notes, index);
                        } else {
                          _goToEditMode(context, notes, index, noteProvider);
                        }
                      },
                      onLongPress: () => _selectAndDeselectNotes(notes, index),
                      child: CardNote(
                        note: notes[index],
                        selectedNotes: selectedNotes,
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                );
              }
            default:
              return Center(
                child: Text(StringsConstants.unknownError),
              );
          }
        },
      ),
      floatingActionButton: isSelectModeActive
          ? _deleteModeFloatingActionButton(context, noteProvider)
          : _addModeFloatingActionButton(context, noteProvider),
    );
  }

  FloatingActionButton _addModeFloatingActionButton(
      BuildContext context, NoteProvider noteProvider) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Future<dynamic> future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NoteFormView();
        }));
        future.then((newNote) {
          if (newNote != null) {
            noteProvider.addNewNote(newNote);
          }
        });
      },
      child: Icon(
        Icons.note_add_outlined,
        color: Colors.white,
      ),
    );
  }

  FloatingActionButton _deleteModeFloatingActionButton(
      BuildContext context, NoteProvider noteProvider) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if (selectedNotes.length == 1) {
          noteProvider.removeNote(selectedNotes.first.id);
        } else {
          for (Note selectedNote in selectedNotes) {
            noteProvider.removeNote(selectedNote.id);
          }
        }
        isSelectModeActive = false;
        selectedNotes = [];
      },
      label: Text(
        StringsConstants.fabDeleteNotes,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void _goToEditMode(BuildContext context, List<Note> notes, int index,
      NoteProvider noteProvider) {
    Future<dynamic> future =
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteEditFormView(note: notes[index]);
    }));
    future.then((newNote) {
      noteProvider.updateNote(newNote);
    });
  }

  void _selectAndDeselectNotes(List<Note> notes, int index) {
    setState(() {
      if (selectedNotes.any((element) => element.id == notes[index].id)) {
        selectedNotes.removeWhere((element) => element.id == notes[index].id);
        if (selectedNotes.length == 0) {
          isSelectModeActive = false;
          selectedNotes = [];
        }
      } else {
        selectedNotes.add(notes[index]);
        isSelectModeActive = true;
      }
    });
  }
}
