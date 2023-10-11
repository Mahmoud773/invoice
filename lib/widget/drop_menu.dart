
import 'package:flutter/material.dart';

Widget dropMenu() {
  var dropDownvalue=1;
  return DropdownButton<int>(
      icon: Icon(Icons.arrow_drop_down_outlined),
      value: dropDownvalue,
      items: const [
        DropdownMenuItem(value: 1,
          child: Text('prepaid' ,
        style: TextStyle(color: Colors.red),) ,),
        DropdownMenuItem(value: 3,
          child: Text('postpaid' ,
          style: TextStyle(color: Colors.red),) ,),
      ],
      onChanged: (value) {
        dropDownvalue = value!;
      });
}