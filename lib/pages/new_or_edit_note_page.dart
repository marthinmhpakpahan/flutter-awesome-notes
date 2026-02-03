import 'package:awesome_notes_firebase/change_notifiers/new_note_controller.dart';
import 'package:awesome_notes_firebase/core/constants.dart';
import 'package:awesome_notes_firebase/widgets/dialog_card.dart';
import 'package:awesome_notes_firebase/widgets/new_tag_dialog.dart';
import 'package:awesome_notes_firebase/widgets/note_icon_button.dart';
import 'package:awesome_notes_firebase/widgets/note_icon_button_outlined.dart';
import 'package:awesome_notes_firebase/widgets/note_tag.dart';
import 'package:awesome_notes_firebase/widgets/note_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final QuillController quillController;
  late final FocusNode focusNode;
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();

    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });
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
          Selector<NewNoteController, bool>(
            selector: (context, newNoteController) =>
                newNoteController.readOnly,
            builder: (context, readOnly, child) => NoteIconButtonOutlined(
              icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
              onPressed: () {
                newNoteController.readOnly = !readOnly;

                if (readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            ),
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
            Selector<NewNoteController, bool>(
              selector: (context, controller) => controller.readOnly,
              builder: (context, readOnly, child) => TextField(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Title here",
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                ),
                canRequestFocus: !readOnly,
                onChanged: (value) {
                  newNoteController.title = value;
                },
              ),
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
                        onPressed: () async {
                          final String? tag = await showDialog<String>(
                            context: context,
                            builder: (context) => DialogCard(child: NewTagDialog(),),
                          );
                          if(tag != null) {
                            newNoteController.addTag(tag);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Selector<NewNoteController, List<String>>(
                    selector: (_, newNoteController) => newNoteController.tags,
                    builder: (_, tags, __) => tags.isEmpty ? Text(
                      "No tags added",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ) : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(tags.length, (index) => NoteTag(label: tags[index], onClosed: () {
                          newNoteController.removeTag(index);
                        })),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),
            Expanded(
              child: Selector<NewNoteController, bool>(
                selector: (_, controller) => controller.readOnly,
                builder: (_, readOnly, _) => Column(
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
                    if (!readOnly)
                      NoteToolbar(quillController: quillController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
