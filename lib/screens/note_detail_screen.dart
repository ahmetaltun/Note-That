import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/note_detail_text_field.dart';
import 'package:note_app/widgets/confirmation_dialog.dart';
import 'package:note_app/sql/sqlite_functions.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  NoteDetail({this.note});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  String _title;
  String _detail;
  bool isEdited;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note.title;
      _detail = widget.note.detail;
    }
    isEdited = false;
  }

  void confirmOnClose(BuildContext context) async {
    if (isEdited) {
      bool isYes = await ConfirmationDialog(
          context: context,
          title: 'Warning',
          messageText: 'Close without saving?',
          yesButtonText: 'Yes',
          noButtonText: 'No');
      if (isYes) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  void deleteThisNote() async {
    bool isYes = await ConfirmationDialog(
        context: context,
        title: "Delete",
        messageText: "Are you sure?",
        yesButtonText: "Yes",
        noButtonText: "No");
    if (isYes) {
      // delete
      await SqliteFunctions().deleteNote(noteId: widget.note.id);
      goBackWithNoteObject(noteId: widget.note.id, deleted: true);
    }
  }

  void goBackWithNoteObject(
      {int noteId,
      bool inserted = false,
      bool updated = false,
      bool deleted = false}) {
    Navigator.pop(context, {
      "note": Note(
        id: noteId,
        title: _title,
        detail: _detail,
        icon: Icon(Icons.create),
      ),
      "isInserted": inserted,
      "isUpdated": updated,
      "isDeleted": deleted,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.note == null
            ? Text('Add New Note')
            : Text(widget.note.title),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: "Go back",
          onPressed: () {
            confirmOnClose(context);
          },
        ),
        actions: <Widget>[
          Visibility(
            visible: widget.note == null ? false : true,
            child: Container(
              child: IconButton(
                tooltip: "Delete this note",
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteThisNote();
                },
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          NoteDetailTextField(
            defaultValue: widget.note == null ? _title : widget.note.title,
            hintText: 'Title is here',
            textOnChange: (val) {
              _title = val;
              isEdited = true;
            },
          ),
          Expanded(
            child: NoteDetailTextField(
              defaultValue: widget.note == null ? _detail : widget.note.detail,
              hintText: 'Note is here',
              inputBorder: InputBorder.none,
              maxLine: null,
              textInputType: TextInputType.multiline,
              textOnChange: (val) {
                _detail = val;
                isEdited = true;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Save changes",
        onPressed: () async {
          // check if null or empty
          if (_title != null &&
              _title != "" &&
              _detail != null &&
              _detail != "") {
            // insert or update
            if (widget.note == null) {
              // insert
              int noteId = await SqliteFunctions().addNote(
                title: _title,
                detail: _detail,
              );
              // go back
              goBackWithNoteObject(noteId: noteId, inserted: true);
            } else {
              // update
              await SqliteFunctions().updateNote(
                noteId: widget.note.id,
                title: _title,
                detail: _detail,
              );
              // go back
              goBackWithNoteObject(noteId: widget.note.id, updated: true);
            }
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
