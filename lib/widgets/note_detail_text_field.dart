import 'package:flutter/material.dart';

class NoteDetailTextField extends StatefulWidget {
  final TextInputType textInputType;
  final int maxLine;
  final Function textOnChange;
  final String defaultValue;
  final InputBorder inputBorder;
  final String hintText;

  NoteDetailTextField(
      {this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.textOnChange,
      this.defaultValue,
      this.inputBorder,
      this.hintText});

  @override
  _NoteDetailTextFieldState createState() => _NoteDetailTextFieldState();
}

class _NoteDetailTextFieldState extends State<NoteDetailTextField> {
  final TextEditingController tec = TextEditingController();

  @override
  void initState() {
    super.initState();
    tec.text = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: tec,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: widget.inputBorder,
          helperStyle: TextStyle(
            decorationColor: Colors.deepPurple,
          ),
        ),
        keyboardType: widget.textInputType,
        maxLines: widget.maxLine,
        onChanged: widget.textOnChange,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
    );
  }
}

/*
decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[700],
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
 */
