import 'package:awesome_notes_firebase/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return const NoteCard(isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}