import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data/Bill_Model.dart';
import 'grid_page.dart';


 class TasdeerOrImport extends StatefulWidget {
   SharedPreferences? sharedPreferences;
   TasdeerOrImport({this.sharedPreferences});

   @override
   State<TasdeerOrImport> createState() => _TasdeerOrImportState();
 }

 class _TasdeerOrImportState extends State<TasdeerOrImport> {
   List<BillTextModel>  myBills= List.empty(growable:true );
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
   void read() {

     List<String>? myBillsStringList = widget.sharedPreferences!.getStringList('myBills');

     if(myBillsStringList!=null)
     {
       myBills =myBillsStringList.map((billString) => BillTextModel.fromJson(
           json.decode(billString))).toList();
     }


   }
   var path='';

   @override
  void initState() {
     path= widget.sharedPreferences!.get('lastPath').toString();
    super.initState();
     read();
  }

   void _openFile(path) {
     OpenFile.open(path);
   }


   @override
   Widget build(BuildContext context) {
     print(myBills);
     return  Scaffold(
       appBar: AppBar(
         leading:IconButton(onPressed: (){
           Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
             return GridPage(sharedPreferences: widget.sharedPreferences,);
           }));
         }, icon:
         Icon(Icons.arrow_back , color: Colors.white,)
         ),
         title: Text('فتح الملف' , style: TextStyle(color: Colors.white),),
         centerTitle: true,
         backgroundColor: Colors.green,
       ),
       backgroundColor: Colors.green[100],
       body: Center(
         child: SingleChildScrollView(

           child: Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             children: List.generate( myBills.length, (index) {
               return MaterialButton(
               onPressed: (){
           _openFile(myBills[index].path);
           },
           child: Text(
           'فتح ملف الفاتورة باسم ${myBills[index].billNumber}',
           style: TextStyle(color: Colors.white , fontSize: 20),
           ),
           color: Colors.green,
           );
           }),
           ),
         ),
       ),);

   }
 }
