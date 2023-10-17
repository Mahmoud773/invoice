
import 'package:flutter/material.dart';
import 'dart:io';
import 'home_screen.dart';
import 'package:excel/excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcell;
import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

import 'package:path/path.dart' as pathP;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';




class AddFatoraScreen extends StatefulWidget {
  const AddFatoraScreen({Key? key}) : super(key: key);

  @override
  State<AddFatoraScreen> createState() => _AddFatoraScreenState();
}

class _AddFatoraScreenState extends State<AddFatoraScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredBillNumber = '';
  var _enteredFirstSerial = '';
  var _enteredSecondSerial = '';
  Duration? executionTime;
  List<String> list=['ahmed' , 'mmmmmm' ,'hhhhhhhh' ];


  Future<void> _createExcell() async{
    _saveItem();
  final xcell.Workbook workbook = xcell.Workbook();
  final xcell.Worksheet sheet = workbook.worksheets[0];

  // sheet.autoFitColumn(1);
  // sheet.getRangeByIndex(5, 1 );
  // sheet.getRangeByName('A1').setText('Hello World!');
 for(int i = 1 ; i<list.length ; i++ ){
   sheet.getRangeByIndex(i, 1).setText(list[i]);
 }
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName ='$path/Output.xlsx';
  final File file = File(fileName);

  await file.writeAsBytes(bytes, flush: true);
  // OpenFile.open(fileName);

  final appDir = await getApplicationDocumentsDirectory();
  final myFileName= pathP.basename(file.path);
 final copiedFile= await file.copy('${appDir.path}/$myFileName');

      final dbPath = await sql.getDatabasesPath();
      final db = await sql.openDatabase(pathP.join(dbPath,'bills.db'),
      onCreate: (db,version) {
        return db.execute('CREATE TABLE my_bills(id TEXT PRIMARY KEY , billNumber TEXT ,'
            'firstSerial TEXT , secondSerial TEXT),excellFile TEXT');
      } , version: 1);
      db.insert('my_bills', {
        'id':1 ,
        "billNumber":_enteredBillNumber,
        "firstSerial":_enteredFirstSerial,
        "secondSerial":_enteredSecondSerial,
        "excellFile":file.path,

      });
}


  void _exportToExcel(){
    final stopwatch = Stopwatch()..start();
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    for (var row = 1; row < 4; row++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = '$_enteredBillNumber';

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = '$_enteredFirstSerial';

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = "$_enteredSecondSerial";

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
          .value = "UI";

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
          .value = "toolkit";
    }
    excel.save(fileName: "MyData.xlsx");
    setState(() {
      executionTime = stopwatch.elapsed;
    });
  }

  void _saveItem(){
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) {
    //       return HomeScreen(billNumber:_enteredBillNumber ,
    //         firstSerial: _enteredFirstSerial,
    //         secondSerial: _enteredSecondSerial,
    //       );
    //     })
    // );
  }
  @override
  Widget build(BuildContext context) {
    // list.add(_enteredBillNumber);
    print('list.length ${list.length}');
    return  Scaffold(
      appBar: AppBar(
        title: TextButton(onPressed: _exportToExcel, child: Text('save')),
        leading: TextButton(onPressed: _createExcell, child: Text('save' , style:
        TextStyle(color: Colors.red),)),
      ),

      body: Form(
        key: _formKey,
        child: Container(
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(label: Text('bill Number'),
              ),
              onSaved: (value){
                _enteredBillNumber = value!;
                setState(() {
                  list.add(_enteredBillNumber);
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: Text('bill Number'),
              ),
              onSaved: (value){
                _enteredFirstSerial = value!;
                setState(() {
                  list.add(_enteredFirstSerial);
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: Text('bill Number'),
              ),
              onSaved: (value){
                _enteredSecondSerial = value!;
                setState(() {
                  list.add(_enteredSecondSerial);
                });
              },
            )
          ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _saveItem ,

        child: TextButton(onPressed: _saveItem
            , child: Text('Save')),),
    );
  }
}
