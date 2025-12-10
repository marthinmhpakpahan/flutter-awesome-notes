import 'package:awesome_notes_firebase/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteToolbar extends StatelessWidget {
  const NoteToolbar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: primary, strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: primary, offset: Offset(4, 4))
        ]
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: const QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateLeft,
              iconSize: 12,
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateRight,
              iconSize: 12,
            ),
            bold: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.bold,
              iconSize: 12,
            ),
            italic: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.italic,
              iconSize: 12,
            ),
            underLine: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.underline,
              iconSize: 12,
            ),
            strikeThrough: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.strikethrough,
              iconSize: 12,
            ),
            color: QuillToolbarColorButtonOptions(
              iconData: FontAwesomeIcons.palette,
              iconSize: 12,
            ),
            backgroundColor: QuillToolbarColorButtonOptions(
              iconData: FontAwesomeIcons.fillDrip,
              iconSize: 12,
            ),
            clearFormat: QuillToolbarClearFormatButtonOptions(
              iconData: FontAwesomeIcons.textSlash,
              iconSize: 12,
            ),
            listNumbers: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.listUl,
              iconSize: 12,
            ),
            search: QuillToolbarSearchButtonOptions(
              iconData: FontAwesomeIcons.magnifyingGlass,
              iconSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}