import 'package:awesome_notes_firebase/models/note.dart';
import 'package:awesome_notes_firebase/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesList extends StatelessWidget {
  const NotesList({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return NoteCard(note: notes[index], isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }

}