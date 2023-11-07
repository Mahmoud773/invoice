import 'package:flutter/material.dart';
Widget textField(){
  return // Note: Same code is applied for the TextFormField as well
    TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey,
          label: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold),),
          enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
}