import 'package:flutter/material.dart';

Future<bool> ConfirmationDialog(
    {BuildContext context,
    String title,
    String messageText,
    String yesButtonText,
    String noButtonText}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(messageText),
          elevation: 5.0,
          actions: <Widget>[
            FlatButton(
              child: Text(yesButtonText),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
            FlatButton(
              child: Text(noButtonText),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
            )
          ],
        );
      });
}
