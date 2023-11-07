import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


 class TasdeerOrImport extends StatefulWidget {
   SharedPreferences? sharedPreferences;
   TasdeerOrImport({this.sharedPreferences});

   @override
   State<TasdeerOrImport> createState() => _TasdeerOrImportState();
 }

 class _TasdeerOrImportState extends State<TasdeerOrImport> {

   void _pickFile() async {
     // opens storage to pick files and the picked file or files
     // are assigned into result and if no file is chosen result is null.
     // you can also toggle "allowMultiple" true or false depending on your need
     final result = await FilePicker.platform.pickFiles(allowMultiple: false);

     // if no file is picked
     if (result == null) return;

     // we will log the name, size and path of the
     // first picked file (if multiple are selected)
     print(result.files.first.name);
     print(result.files.first.size);
     print(result.files.first.path);
   }
   var path='';

   @override
  void initState() {
     path= widget.sharedPreferences!.get('lastPath').toString();
    super.initState();
  }

   void _openFile(path) {
     OpenFile.open(path);
   }


   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       backgroundColor: Colors.green[100],
       body: Center(
         child: MaterialButton(
           onPressed: (){
             _openFile(path);
           },
           child: Text(
             'استيراد وفتح الملف',
             style: TextStyle(color: Colors.white),
           ),
           color: Colors.green,
         ),
       ),);

   }
 }
