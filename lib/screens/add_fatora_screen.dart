// import 'package:flutter/material.dart';
//
// import 'home_screen.dart';
// import 'package:excel/excel.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
//
//
// class AddFatoraScreen extends StatefulWidget {
//   const AddFatoraScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddFatoraScreen> createState() => _AddFatoraScreenState();
// }
//
// class _AddFatoraScreenState extends State<AddFatoraScreen> {
//   final _formKey = GlobalKey<FormState>();
//   var _enteredBillNumber = '';
//   var _enteredFirstSerial = '';
//   var _enteredSecondSerial = '';
//   Duration? executionTime;
//   void _exportToExcel(){
//     final stopwatch = Stopwatch()..start();
//     final excel = Excel.createExcel();
//     final Sheet sheet = excel[excel.getDefaultSheet()!];
//     for (var row = 1; row < 4; row++) {
//       sheet
//           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//           .value = '$_enteredBillNumber';
//
//       sheet
//           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//           .value = '$_enteredFirstSerial';
//
//       sheet
//           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//           .value = "$_enteredSecondSerial";
//
//       sheet
//           .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
//           .value = "UI";
//
//       sheet
//           .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
//           .value = "toolkit";
//     }
//     excel.save(fileName: "MyData.xlsx");
//     setState(() {
//       executionTime = stopwatch.elapsed;
//     });
//   }
//
//   void _saveItem(){
//     _formKey.currentState!.validate();
//     _formKey.currentState!.save();
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) {
//         return HomeScreen(billNumber:_enteredBillNumber ,
//         firstSerial: _enteredFirstSerial,
//           secondSerial: _enteredSecondSerial,
//         );
//       })
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: TextButton(onPressed: _exportToExcel, child: Text('save')),
//         leading: TextButton(onPressed: _exportToExcel, child: Text('save' , style:
//           TextStyle(color: Colors.red),)),
//       ),
//
//       body: Form(
//         key: _formKey,
//         child:  Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(label: Text('bill number') ,
//               ),
//               validator: (value) {
//                 if(value!.isEmpty || value==null || value.trim().length==1)
//                 {
//                   return 'please Enter vaild value' ;
//                 }
//                 return null ;
//               },
//               onSaved: (value) {
//                 _enteredBillNumber =value!;
//               },
//               onChanged: (value) {
//                 _enteredBillNumber =value!;
//               },
//             ) ,
//             TextFormField(
//               decoration: InputDecoration(label: Text('bill number') ,
//               ),
//               validator: (value) {
//                 if(value!.isEmpty || value==null || value.trim().length==1)
//                 {
//                   return 'please Enter vaild value' ;
//                 }
//                 return null ;
//               },
//               onSaved: (value){
//                 _enteredFirstSerial =value! ;
//               },
//               onChanged: (value) {
//                 _enteredFirstSerial =value!;
//               },
//             ) ,
//             TextFormField(
//               decoration: InputDecoration(label: Text('bill number') ,
//               ),
//               validator: (value) {
//                 if(value!.isEmpty || value==null || value.trim().length==1)
//                 {
//                   return 'please Enter vaild value' ;
//                 }
//                 return null ;
//               },
//               onSaved: (value){
//                 _enteredSecondSerial =value! ;
//               },
//               onChanged: (value) {
//                 _enteredSecondSerial =value!;
//               },
//             ) ,
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: _saveItem ,
//
//       child: TextButton(onPressed: _saveItem
//           , child: Text('Save')),),
//     );
//   }
// }
