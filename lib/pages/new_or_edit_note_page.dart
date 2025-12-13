import 'package:awesome_notes_firebase/core/constants.dart';
import 'package:awesome_notes_firebase/widgets/note_icon_button.dart';
import 'package:awesome_notes_firebase/widgets/note_icon_button_outlined.dart';
import 'package:awesome_notes_firebase/widgets/note_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final QuillController quillController;
  late final FocusNode focusNode;
  late bool readOnly;

  @override
  void initState() {
    super.initState();
    quillController = QuillController.basic();

    focusNode = FocusNode();

    if (widget.isNewNote) {
      focusNode.requestFocus();
      readOnly = false;
    } else {
      readOnly = true;
    }

    quillController.readOnly = readOnly;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(widget.isNewNote ? "New Note" : "Edit Note"),
        actions: [
          NoteIconButtonOutlined(
            icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
            onPressed: () {
              setState(() {
                readOnly = !readOnly;

                if (readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              });
            },
          ),
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.check,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Title here",
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
              canRequestFocus: !readOnly,
            ),
            if (!widget.isNewNote) ...[
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Last Modified",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "07 December 2023, 03:35 PM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Created",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "06 December 2023, 03:35 PM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text(
                        "Tags",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NoteIconButton(
                        icon: FontAwesomeIcons.circlePlus,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "No tags added",
                    style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: QuillEditor.basic(
                      controller: quillController,
                      config: const QuillEditorConfig(
                        placeholder: "Note here...",
                        expands: true,
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                  if (!readOnly) NoteToolbar(quillController: quillController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
