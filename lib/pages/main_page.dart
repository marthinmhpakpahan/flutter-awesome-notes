import 'package:awesome_notes_firebase/core/constants.dart';
import 'package:awesome_notes_firebase/widgets/note_card.dart';
import 'package:awesome_notes_firebase/widgets/note_fab.dart';
import 'package:awesome_notes_firebase/widgets/note_grid.dart';
import 'package:awesome_notes_firebase/widgets/note_list.dart';
import 'package:awesome_notes_firebase/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> dropdownOptions = ["Date modified", "Date created"];

  late String dropdownValue = dropdownOptions.first;

  bool isDescending = true;
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Awesome Notes 📒"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.rightFromBracket),
            style: IconButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: black),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: NoteFab(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    icon: FaIcon(
                      isDescending
                          ? FontAwesomeIcons.arrowDown
                          : FontAwesomeIcons.arrowUp,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: gray700,
                  ),
                  SizedBox(width: 16),
                  DropdownButton(
                    value: dropdownValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownWideShort,
                        size: 18,
                        color: gray700,
                      ),
                    ),
                    underline: SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(16),
                    isDense: true,
                    items: dropdownOptions
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Text(e),
                                if (e == dropdownValue) ...[
                                  SizedBox(width: 8),
                                  Icon(Icons.check),
                                ],
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    selectedItemBuilder: (context) =>
                        dropdownOptions.map((e) => Text(e)).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!.toString();
                      });
                    },
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    icon: FaIcon(
                      isGrid
                          ? FontAwesomeIcons.tableCellsLarge
                          : FontAwesomeIcons.bars,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: gray700,
                  ),
                ],
              ),
            ),
            Expanded(child: isGrid ? NotesGrid() : NotesList()),
          ],
        ),
      ),
    );
  }
}