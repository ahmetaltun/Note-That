import 'package:flutter/cupertino.dart';

class Note {
  int id;
  Icon icon;
  String title;
  String detail;
  Note({@required this.id, @required this.title, this.detail, this.icon});
}
