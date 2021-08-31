import 'package:flutter/material.dart';
import 'package:notes/src/models/note_model.dart';

class CardNote extends StatelessWidget {
  final Note note;
  final List<Note> selectedNotes;
  CardNote({
    Key? key,
    required this.note,
    required this.selectedNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.body,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.time,
                ),
                selectedNotes.any((element) => element.id == note.id)
                    ? Icon(
                        Icons.check_circle,
                      )
                    : Icon(
                        Icons.circle_outlined,
                        color: Colors.transparent,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
