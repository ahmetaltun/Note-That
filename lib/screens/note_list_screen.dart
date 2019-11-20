import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/note_card.dart';
import 'note_detail_screen.dart';
import 'package:note_app/sql/sqlite_functions.dart';

class NoteListScreen extends StatefulWidget {
  List<Note> noteList;
  NoteListScreen({this.noteList});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> navigateDetailScreen({Note note}) async {
    Map fromOtherScreen =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(
        note: note != null ? note : null,
      );
    }));
    if (fromOtherScreen != null) {
      Note newNoteObject = fromOtherScreen["note"];
      if (fromOtherScreen["isInserted"] == true) {
        // add note object to list
        widget.noteList.insert(0, newNoteObject);
      } else if (fromOtherScreen["isUpdated"] == true) {
        // find note object in the list and change title and detail
        for (int i = 0; i < widget.noteList.length; i++) {
          if (widget.noteList[i].id == newNoteObject.id) {
            widget.noteList[i].title = newNoteObject.title;
            widget.noteList[i].detail = newNoteObject.detail;
          }
        }
      } else if (fromOtherScreen["isDeleted"] == true) {
        // find note object in the list and remove
        for (int i = 0; i < widget.noteList.length; i++) {
          if (widget.noteList[i].id == newNoteObject.id)
            widget.noteList.removeAt(i);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
        centerTitle: false,
        actions: <Widget>[
          Center(
            child: Text(
              widget.noteList.length <= 1
                  ? '${widget.noteList.length} Note'
                  : '${widget.noteList.length} Notes',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.noteList.length,
        itemBuilder: (BuildContext ctc, int index) => NoteCard(
          note: widget.noteList[index],
          onTapFunction: () async {
            await navigateDetailScreen(note: widget.noteList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigateDetailScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
