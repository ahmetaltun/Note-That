import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'note_icon.dart';
import 'package:note_app/screens/note_detail_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onTapFunction;
  NoteCard({this.note, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Material(
        elevation: 5.0,
        child: Container(
          margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          child: Row(
            children: <Widget>[
              NoteIcon(icon: note.icon),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      note.title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      note.detail,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
