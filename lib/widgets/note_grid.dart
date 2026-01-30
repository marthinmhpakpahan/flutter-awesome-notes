import 'package:awesome_notes_firebase/models/note.dart';
import 'package:awesome_notes_firebase/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(note: notes[index], isInGrid: true);
      },
    );
  }
}
