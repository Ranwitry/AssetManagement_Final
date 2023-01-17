import 'package:flutter/material.dart';

myAlert(context, text, {onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 24,
      content: Text(text, style: TextStyle(fontFamily: "NunitoSans")),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xffDF9A9A)),
          onPressed: onPressed,
          child: const Text(
            'Ya',
            style: TextStyle(fontFamily: "NunitoSans", color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xffE5E5E5)),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Tidak',
            style: TextStyle(fontFamily: "NunitoSans", color: Colors.black),
          ),
        ),
      ],
    ),
  );
}


myDoubleAlert(context, title, text1, text2, {onPressed1, onPressed2}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 24,
      content: Text(title, style: TextStyle(fontFamily: "NunitoSans")),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xffDF9A9A)),
          onPressed: onPressed1,
          child: Text(
            text1,
            style: TextStyle(fontFamily: "NunitoSans", color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xffE5E5E5)),
          onPressed: onPressed2,
          child: Text(
            text2,
            style: TextStyle(fontFamily: "NunitoSans", color: Colors.black),
          ),
        ),
      ],
    ),
  );
}