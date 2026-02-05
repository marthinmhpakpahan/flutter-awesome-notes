import 'package:awesome_notes_firebase/core/constants.dart';
import 'package:flutter/material.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        side: BorderSide(color: black),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8),
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
    );
  }
}