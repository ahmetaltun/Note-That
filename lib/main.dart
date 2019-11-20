import 'package:flutter/material.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'sql/sqlite_functions.dart';

void main() async => runApp(
      MaterialApp(
        home: NoteListScreen(
          noteList: await SqliteFunctions().getNotes(),
        ),
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.deepPurple,
          textSelectionColor: Colors.deepPurple,
          textSelectionHandleColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            elevation: 5.0,
          ),
        ),
      ),
    );
