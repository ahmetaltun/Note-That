import 'package:flutter/material.dart';

class NoteIcon extends StatelessWidget {
  final Icon icon;
  NoteIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: icon,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        color: Colors.grey[700],
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(right: 12.0),
    );
  }
}
