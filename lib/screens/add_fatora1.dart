// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:excel/excel.dart';
// import 'package:invoice/screens/home_screen.dart';
// import 'package:invoice/shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcell;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
//
// import 'package:path/path.dart' as pathP;
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';
//
// import '../dummy_data/Bill_Model.dart';
// import '../dummy_data/dummy_data.dart';
// import '../dummy_data/file_storage.dart';
// import '../widget/drop_menu.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AddFatora1 extends StatefulWidget {
//   SharedPreferences? sharedPreferences;
//
//    AddFatora1({this.sharedPreferences});
//
//   @override
//   State<AddFatora1> createState() => _AddFatora1State();
// }
//
// class _AddFatora1State extends State<AddFatora1> {
//   bool addedPath=false;
//   final _formKey = GlobalKey<FormState>();
//   Map<String,String> serialMap={};
//   var _enteredBillType=0;
//   var entereditemNumber = '';
//   var enteredfileName = '';
//   var _enteredBillNumber = '';
//   var _enteredFirstSerial = '';
//   var _enteredSecondSerial = '';
//   var _enteredThhirdSerial = '';
//   bool addListTextField = false;
//   BillTextModel? billTextModel;
//   var filepath='';
//   List<String> _list=['ahmed' , 'mmmmmm' ,'hhhhhhhh' ];
//   static const myList = {
//     "name":"GeeksForGeeks"
//   };
//   Map<String,String> _map={};
//
//   List<BillTextModel>  myBills= [];
//   // List<BillTextModel>  bills= List.empty(growable:true );
//
//
//   var pppp='';
//   var ssss='';
//   // Shared Preferences
//   // late SharedPreferences sp;
//   // late SharedPreferences _sharedPreferences;
//   // getSharedPrefrences() async {
//   //   sp = await SharedPreferences.getInstance();
//   //   _sharedPreferences= await SharedPreferences.getInstance();
//   //   readFromSp();
//   // }
//   //
//   // void saveToSp(){
//   //     List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
//   //     sp.setStringList('myBills', myBillsStringList);
//   //     _sharedPreferences.setStringList('myBills', myBillsStringList);
//   // }
//   //
//   // void readFromSp() {
//   //
//   //   List<String>? myBillsStringList = sp.getStringList('myBills');
//   //
//   //   if(myBillsStringList!=null)
//   //     {
//   //       myBills =myBillsStringList.map((billString) => BillTextModel.fromJson(
//   //         json.decode(billString))).toList();
//   //     }
//   //   List<String>? myBillsStringList2=_sharedPreferences.getStringList('myBills');
//   //   if(myBillsStringList2!=null)
//   //   {
//   //     myBills =myBillsStringList2.map((billString) => BillTextModel.fromJson(
//   //         json.decode(billString))).toList();
//   //   }
//   //   setState(() {
//   //
//   //   });
//   // }
//
//   // for passed shared
//   void save(){
//     List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
//     widget.sharedPreferences!.setStringList('myBills', myBillsStringList);
//     print('true or false ${widget.sharedPreferences!.setStringList('myBills', myBillsStringList)}}');
//
//   }
//   void read() {
//
//     List<String>? myBillsStringList = widget.sharedPreferences!.getStringList('myBills');
//
//     if(myBillsStringList!=null)
//     {
//       myBills =myBillsStringList.map((billString) => BillTextModel.fromJson(
//           json.decode(billString))).toList();
//     }
//
//     setState(() {
//
//     });
//   }
//   @override
//   void initState() {
//     // getSharedPrefrences();
//     super.initState();
//     // getSharedPrefrences();
//     print('init state');
//
//   }
//   //   // _saveBill(list,name);
//   //   // _saveBillModelList();
//   //   final xcell.Workbook workbook = xcell.Workbook();
//   //   final xcell.Worksheet sheet = workbook.worksheets[0];
//   //   sheet.getRangeByIndex(1, 1).setText("Title");
//   //   sheet.getRangeByIndex(1, 2).setText("Link");
//   //   // for (var i = 0; i < DUMMYDATA.length; i++) {
//   //   //   final item = DUMMYDATA[i];
//   //   //   sheet.getRangeByIndex(i + 2, 1).setText(item["title"].toString());
//   //   //   sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//   //   // }
//   //   for (var i = 0; i < list.length; i++) {
//   //     final item = DUMMYDATA[i];
//   //
//   //     sheet.getRangeByIndex(i + 2, 1).setText(list[i]);
//   //     // sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//   //   }
//   //   final List<int> bytes = workbook.saveAsStream();
//   //   FileStorage.writeString(bytes, "$name.xlsx", );
//   //   workbook.dispose();
//   // }
//
//   Future<void> _createText(Map<String,String> map ,String name) async{
//     // _saveItem();
//     final xcell.Workbook workbook = xcell.Workbook();
//     final xcell.Worksheet sheet = workbook.worksheets[0];
//     sheet.getRangeByIndex(1, 1).setText("Title");
//     sheet.getRangeByIndex(1, 2).setText("Link");
//     // for (var i = 0; i < DUMMYDATA.length; i++) {
//     //   final item = DUMMYDATA[i];
//     //   sheet.getRangeByIndex(i + 2, 1).setText(item["title"].toString());
//     //   sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//     // }
//     for (var i = 0; i < _list.length; i++) {
//       final item = DUMMYDATA[i];
//
//       sheet.getRangeByIndex(i + 2, 1).setText(_list[i]);
//       // sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//     }
//     final List<int> bytes = workbook.saveAsStream();
//     FileStorage.writeCounter(map.toString(), "$name.txt", );
//
//     workbook.dispose();
//   }
//   // Future<void> _createBillText(List<String> list ,String name) async{
//   //   var result = { for (var v in list) v[0]: v[1] };
//   //   final xcell.Workbook workbook = xcell.Workbook();
//   //   final xcell.Worksheet sheet = workbook.worksheets[0];
//   //   sheet.getRangeByIndex(1, 1).setText("Title");
//   //   sheet.getRangeByIndex(1, 2).setText("Link");
//   //   // for (var i = 0; i < DUMMYDATA.length; i++) {
//   //   //   final item = DUMMYDATA[i];
//   //   //   sheet.getRangeByIndex(i + 2, 1).setText(item["title"].toString());
//   //   //   sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//   //   // }
//   //   for (var i = 0; i < _list.length; i++) {
//   //     final item = DUMMYDATA[i];
//   //
//   //     sheet.getRangeByIndex(i + 2, 1).setText(_list[i]);
//   //     // sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
//   //   }
//   //   final List<int> bytes = workbook.saveAsStream();
//   //   FileStorage.writeCounter(result.toString(), "$name.txt", );
//   //
//   //   workbook.dispose();
//   //   _saveItem(list);
//   // }
//   // Future<String> get _localPath async {
//   //   final directory = await getApplicationDocumentsDirectory();
//   //
//   //   return directory.path;
//   // }
//   // Future<File> get _localFile async {
//   //   final path = await _localPath;
//   //   return File('$path/counter.txt');
//   // }
//   // Future<File> writeCounter(List<int> bytes) async {
//   //   final file = await _localFile;
//   //
//   //   // Write the file
//   //   return file.writeAsBytes(bytes);
//   // }
//
//   // void _exportToExcel(){
//   //   final stopwatch = Stopwatch()..start();
//   //   final excel = Excel.createExcel();
//   //   final Sheet sheet = excel[excel.getDefaultSheet()!];
//   //   for (var row = 1; row < 4; row++) {
//   //     sheet
//   //         .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//   //         .value = '$_enteredBillNumber';
//   //
//   //     sheet
//   //         .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//   //         .value = '$_enteredFirstSerial';
//   //
//   //     sheet
//   //         .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//   //         .value = "$_enteredSecondSerial";
//   //
//   //     sheet
//   //         .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
//   //         .value = "UI";
//   //
//   //     sheet
//   //         .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
//   //         .value = "toolkit";
//   //   }
//   //   excel.save(fileName: "MyData.xlsx");
//   //   setState(() {
//   //     executionTime = stopwatch.elapsed;
//   //   });
//   // }
//
//   Future<void> _createTextFile ({required Map<String,String> map ,required String name
//     ,  BillTextModel? billTextModel1}) async {
//     // SharedPreferences.getInstance().then((value)
//     // {
//     //   sp= value;
//     //   _formKey.currentState!.save();
//     //   List<String> list =[];
//     //   map.forEach((key, value) { list.add(value);});
//     //   list.map((e) => {"" :  ""});
//     //   BillTextModel    billTextModel2=BillTextModel(id: DateTime.now().toString(), path: '', fileName: enteredfileName,
//     //       billType: _enteredBillType,
//     //       billNumber: _enteredBillNumber,
//     //       itemNumber: entereditemNumber, serialMap:list);
//     //
//     //   _map= {
//     //     'id':billTextModel2!.id,
//     //     'enteredfileName': billTextModel2!.fileName ,
//     //     'billType':billTextModel2!.billType.toString() ,
//     //     'billNumber':billTextModel2!.billNumber,
//     //     'itemNumber':billTextModel2!.itemNumber,
//     //     'serialList':billTextModel2!.serialMap.toString()
//     //   };
//     //
//     //   FileStorage.writeCounter(
//     //       _map.toString(), "$name.txt");
//     //   _saveItem(map ,FileStorage.filePath);
//     //
//     //   print('${FileStorage.filePath}');
//     //   // Map<String,String> _map= {
//     //   //   'id':billTextModel!.id,
//     //   //    'billType':billTextModel.billType.toString() ,
//     //   //     'serialList':billTextModel.serialMap.toString()
//     //   // };
//     //
//     //
//     //
//     // });
//
//
//     _formKey.currentState!.save();
//     List<String> list =[];
//     map.forEach((key, value) { list.add(value);});
//     list.map((e) => {"" :  ""});
//     BillTextModel    billTextModel2=BillTextModel(id: DateTime.now().toString(), path: '', fileName: enteredfileName,
//         billType: _enteredBillType,
//         billNumber: _enteredBillNumber,
//         itemNumber: entereditemNumber, serialMap:list, branchNumber: '');
//
//     _map= {
//       'id':billTextModel2!.id,
//       'enteredfileName': billTextModel2!.fileName ,
//       'billType':billTextModel2!.billType.toString() ,
//       'billNumber':billTextModel2!.billNumber,
//       'itemNumber':billTextModel2!.itemNumber,
//       'serialList':billTextModel2!.serialMap.toString()
//     };
//
//     FileStorage.writeCounter(
//         _map.toString(), "$name.txt").then((value) {
//       List<String> list =[];
//       map.forEach((key, value) { list.add(value);});
//       list.map((e) => {"" :  ""});
//       billTextModel=BillTextModel(id: DateTime.now().toString(), path:value.path, fileName: enteredfileName,
//           billType: _enteredBillType,
//           billNumber: _enteredBillNumber,
//           itemNumber: entereditemNumber, serialMap:list, branchNumber: '');
//       myBills.add(billTextModel!);
//       save();
//       widget.sharedPreferences!.setString('lastPath', value.path);
//       addedPath=true;
//
//     });
//
//
//
//     // _formKey.currentState!.save();
//     // List<String> list =[];
//     // map.forEach((key, value) { list.add(value);});
//     // list.map((e) => {"" :  ""});
//     // billTextModel=BillTextModel(id: DateTime.now().toString(), path: '', fileName: enteredfileName,
//     //     billType: _enteredBillType,
//     //     billNumber: _enteredBillNumber,
//     //     itemNumber: entereditemNumber, serialMap:list);
//     //
//     // _map= {
//     //   'id':billTextModel!.id,
//     //   'enteredfileName': billTextModel!.fileName ,
//     //   'billType':billTextModel!.billType.toString() ,
//     //   'billNumber':billTextModel!.billNumber,
//     //   'itemNumber':billTextModel!.itemNumber,
//     //   'serialList':billTextModel!.serialMap.toString()
//     // };
//     //
//     // FileStorage.writeCounter(
//     //     _map.toString(), "$name.txt");
//     // _saveItem(map ,FileStorage.filePath);
//     // filepath=FileStorage.filePath;
//     // //for check with no shared preeferences
//     //
//     // print('${FileStorage.filePath}');
//     // billTextModel=BillTextModel(id: DateTime.now().toString(), path: FileStorage.filePath,
//     //     fileName: enteredfileName,
//     //     billType: _enteredBillType,
//     //     billNumber: _enteredBillNumber,
//     //     itemNumber: entereditemNumber, serialMap:list);
//     // bills.add(billTextModel!);
//     // Map<String,String> _map= {
//     //   'id':billTextModel!.id,
//     //    'billType':billTextModel.billType.toString() ,
//     //     'serialList':billTextModel.serialMap.toString()
//     // };
//
//   }
//   _createTextFile2 ({required Map<String,String> map ,required String name
//     ,  BillTextModel? billTextModel1})  {
//     if(_formKey.currentState!.validate())
//     {
//       _formKey.currentState!.save();
//       List<String> list =[];
//       map.forEach((key, value) { list.add(value);});
//       list.map((e) => {"" :  ""});
//       BillTextModel    billTextModel2=BillTextModel(id: DateTime.now().toString(), path: '',
//           fileName: enteredfileName,
//           billType: _enteredBillType,
//           billNumber: _enteredBillNumber,
//           itemNumber: entereditemNumber, serialMap:list, branchNumber: '');
//
//       _map= {
//
//         'File Name': billTextModel2!.fileName ,
//         'Bill Type':billTextModel2!.billType.toString() ,
//         'Bill Number':billTextModel2!.billNumber,
//         'Item Number':billTextModel2!.itemNumber,
//         'Serials':billTextModel2!.serialMap.toString()
//       };
//       var concatenate = StringBuffer();
//
//       billTextModel2!.serialMap.forEach((item){
//         concatenate.write('\n serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n');
//       });
//       final String content= 'Bill Type : ${billTextModel2!.billType.toString()}  \n'
//           'Bill Number: ${billTextModel2!.billNumber} \n '
//           'Item Number : ${billTextModel2!.itemNumber} \n'
//           'Serials : $concatenate '  ;
//
//       FileStorage.writeCounter(
//           content, "$name.txt").then((value) {
//         List<String> list =[];
//         map.forEach((key, value) { list.add(value);});
//         list.map((e) => {"" :  ""});
//         billTextModel=BillTextModel(id: DateTime.now().toString(), path:value.path, fileName: enteredfileName,
//             billType: _enteredBillType,
//             billNumber: _enteredBillNumber,
//             itemNumber: entereditemNumber, serialMap:list, branchNumber: '');
//         myBills.add(billTextModel!);
//         save();
//         widget.sharedPreferences!.setString('lastPath', value.path);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.blue, width: 2),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           backgroundColor: Colors.blue,
//           duration: Duration(milliseconds: 2000),
//           dismissDirection: DismissDirection.up,
//           content: Text('تم حفظ الفاتورة'
//           , style: TextStyle(color: Colors.white),) ,
//         ));
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//           return HomeScreen( sharedPreferences: widget.sharedPreferences,
//             backAfterAddBill: true, billLList: [],);
//         }));
//       });
//     }
//
//
//   }
//
//   void _saveItem(Map<String,String> map , String path  ){
//
//     if(_formKey.currentState!.validate()){
//       _formKey.currentState!.save();
//
//       List<String> list =[];
//       map.forEach((key, value) { list.add(value);});
//       list.map((e) => {"" :  ""});
//       billTextModel=BillTextModel(id: DateTime.now().toString(), path: path, fileName: enteredfileName,
//           billType: _enteredBillType,
//           billNumber: _enteredBillNumber,
//           itemNumber: entereditemNumber, serialMap:list, branchNumber: '');
//       myBills.add(billTextModel!);
//       save();
//     }
//
//     // List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
//     // sp.setStringList('myBills', myBillsStringList);
//     // saveToSp();
//     // _map= billTextModel!.toJson() as Map<String ,String>;
//     // _map= {
//     //   'id':billTextModel!.id,
//     //   'path':path,
//     //   'enteredfileName': billTextModel!.fileName ,
//     //   'billType':billTextModel!.billType.toString() ,
//     //   'billNumber':billTextModel!.billNumber,
//     //   'itemNumber':billTextModel!.itemNumber,
//     //   'serialList':billTextModel!.serialMap.toString()
//     // };
//     // BillModel billModel = BillModel.fromJson(json);
//     // Navigator.of(context).push(
//     //     MaterialPageRoute(builder: (context) {
//     //       return HomeScreen(billNumber:_enteredBillNumber ,
//     //         firstSerial: _enteredFirstSerial,
//     //         secondSerial: _enteredSecondSerial,
//     //       );
//     //     })
//     // );
//   }
//   var dropDownvalue=1;
//   var noOfSerials=0;
//   List<FocusNode> focusList=[];
//   final focus = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     _enteredBillType=dropDownvalue;
//
//     // list.add(_enteredBillNumber);
//     print('widget.sharedPreferences ${widget.sharedPreferences}');
//
//     // print('ssss ${ssss}');
//
//     print(serialMap.toString());
//     read();
//     print('myBIlls${myBills.length}');
//     print('myBIlls${widget.sharedPreferences!.getStringList('myBills')}');
//     // print('${map['_enteredFirstSerial']}');
//     // BillTextModel _myTextMapList = BillTextModel(1 , 'bill', map) ;
//
//     List<String> _serialList = [];
//     print('billTextModel${billTextModel?.billNumber.toString()}');
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.green,
//       title: Center(
//         child: Text('اضافة فاتورة' , style: TextStyle(color: Colors.white ,
//         fontWeight: FontWeight.bold , ),
//         ),
//       ),
//         actions: [
//           TextButton(onPressed: (){
//             // _createTextFile(map: map , name: '$enteredfileName'
//             //     , billTextModel1:  billTextModel);
//             // List<String> list1 =[];
//             // map.forEach((keymn, value) { list1.add(value);});
//             // list1.map((e) => {"" :  ""});
//             _createTextFile2(map: serialMap ,name: '$enteredfileName');
//
//           },
//               child: Text('حفظ' ,style:
//               TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
//                   fontSize: 20),))
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: Container(
//           margin:EdgeInsets.all(10) ,
//           padding: EdgeInsets.only(left: 15 , right: 15),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                          width: width*80/100,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.black.withOpacity(0.1),
//                           boxShadow: [
//                             BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3),
//                           ],
//                         ),
//                         child:
//                         DropdownButton<int>(
//                           padding: EdgeInsets.all(5),
//                           hint: Text('نوع الفاتورة', style: TextStyle(color: Colors.black
//                               ,fontWeight: FontWeight.bold
//                           ),),
//                           icon: Icon(Icons.arrow_drop_down_outlined),
//                           value: dropDownvalue,
//                           items: const [
//                             DropdownMenuItem(value: 1,
//                               child: Text('نقدى' ,
//                                 style: TextStyle(color: Colors.black
//                                     ,fontWeight: FontWeight.bold),) ,),
//                             DropdownMenuItem(value: 3,
//                               child: Text('أجلة' ,
//                                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) ,),
//                           ],
//                           onChanged: (value) {
//                             dropDownvalue = value!;
//                             _enteredBillType =value;
//                             setState(() {
//
//                             });
//                           } ,
//                         ),
//
//                       ),
//                       SizedBox(width: 30,),
//
//                       Container(
//                         height: 40,
//                         width: width*30/100,
//                         child: Center(
//                           child: Text('نوع الفاتورة' ,style:
//                           TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),
//                               textAlign: TextAlign.center),
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.green,
//                           boxShadow: [
//                             BoxShadow(color: Colors.green, spreadRadius: 3),
//                           ],
//                         ), ),
//
//                     ],
//                   ),
//                 ),
//                 // TextFormField(
//                 //   decoration: InputDecoration(label: Text('bill Number'),
//                 //   ),
//                 //   onSaved: (value){
//                 //     _enteredBillType =  int.parse(value!);
//                 //     setState(() {
//                 //       _list.add(_enteredBillType.toString());
//                 //       // _serialList.add(_enteredBillNumber);
//                 //       // map['_enteredBillType']=_enteredBillType.toString();
//                 //
//                 //     });
//                 //   },
//                 //
//                 // ),
//                 Container(
//                   width:width*80/100 ,
//                   child: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         filled: true,
//                         alignLabelWithHint: false,
//
//                         label: Text('اسم الملف',
//                           style: TextStyle(fontWeight: FontWeight.bold ,color:
//                           Colors.black), textAlign: TextAlign.right,),
//                         fillColor: Colors.black.withOpacity(0.1),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                       ),
//                       validator: (value){
//                         if(value!.isEmpty ||value.length<1)
//                         {return ' please Enter Valid value' ;}
//                         else return null ;
//
//                       },
//                       onSaved: (value){
//                         enteredfileName =  value!;
//                         setState(() {
//                           _list.add(enteredfileName.toString());
//                           // _serialList.add(_enteredBillNumber);
//                           // map['_enteredBillType']=_enteredBillType.toString();
//
//                         });
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           enteredfileName=value;
//
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 Container(
//
//                   width:width*80/100 ,
//                   child: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         filled: true,
//                         alignLabelWithHint: false,
//                         label: Text('رقم الفاتورة',
//                           style: TextStyle(fontWeight: FontWeight.bold ,color:
//                           Colors.black), textAlign: TextAlign.right,),
//                         fillColor: Colors.black.withOpacity(0.1),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                       ),
//                       onChanged: (value){
//                         setState(() {
//                           _enteredBillNumber = value!;
//                         });
//                       },
//                       onSaved: (value){
//
//                         setState(() {
//                           _enteredBillNumber = value!;
//                           _list.add(_enteredBillNumber);
//                           // _serialList.add(_enteredBillNumber);
//                           //  map['_enteredBillNumber']=_enteredBillNumber;
//
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 Container (
//
//                   width:width*80/100 ,
//                   child: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         filled: true,
//                         alignLabelWithHint: false,
//                         label: Text('رقم الصنف',
//                           style: TextStyle(fontWeight: FontWeight.bold ,color:
//                           Colors.black), textAlign: TextAlign.right,),
//                         fillColor: Colors.black.withOpacity(0.1),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                       ),
//                       onSaved: (value){
//                         entereditemNumber = value!;
//                         setState(() {
//                           _list.add(entereditemNumber);
//                           // _serialList.add(_enteredBillNumber);
//                           //  map['entereditemNumber']=entereditemNumber;
//
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//
//
//
//                 //
//                 // serial of fatora
//                 Container(
//                   width:width*80/100 ,
//                   child: Row(
//                      mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width:width*25/100 ,
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: TextFormField(
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                 borderRadius: BorderRadius.circular(50.0),
//                               ),
//                               filled: true,
//                               alignLabelWithHint: false,
//                               label: Text('عدد السيريال',
//                                 style: TextStyle(color:
//                                 Colors.black ,fontSize: 15), textAlign: TextAlign.right,),
//                               fillColor: Colors.black.withOpacity(0.1),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                 borderRadius: BorderRadius.circular(50.0),
//                               ),
//                             ),
//                             keyboardType: TextInputType.number,
//
//                             onChanged: (value){
//                               noOfSerials = int.parse(value);
//                               addListTextField=true;
//                               for(var i=0 ; i <noOfSerials ;i++){
//                                 focusList.insert(i, FocusNode());
//                               }
//                               setState(() {
//
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//
//                       Container(
//                         height: 40,
//                                width: width*50/100,
//                           child: Center(
//                             child: Text('عدد السيريال للاجهزة' ,style:
//                             TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),
//                                 textAlign: TextAlign.center),
//                           ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.green,
//                           boxShadow: [
//                             BoxShadow(color: Colors.green, spreadRadius: 3),
//                           ],
//                         ), ),
//                     ],
//                   ),
//                 ),
//
//                 if(addListTextField)
//                   Column(
//                     children:List.generate(noOfSerials, (ind) {
//                       if(ind == noOfSerials-1){
//                         return
//                           Container(
//                             width:width*75/100 ,
//                             child: Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: TextFormField(
//                                 textInputAction: TextInputAction.done,
//                                 focusNode: focusList[noOfSerials-1],
//                                 autofocus: true,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                     borderRadius: BorderRadius.circular(50.0),
//                                   ),
//                                   filled: true,
//                                   alignLabelWithHint: false,
//
//                                   label: Text('سيريال رقم${ind+1}',
//                                     style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                     Colors.black), textAlign: TextAlign.right,),
//                                   fillColor: Colors.black.withOpacity(0.1),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                     borderRadius: BorderRadius.circular(50.0),
//                                   ),
//                                 ),
//                                 validator: (value){
//                                   if(value!.isEmpty ||value!.length<1){
//
//                                   }
//                                 },
//                                 onSaved: (value){
//                                   if(value!.isEmpty ||value!.length<1){
//                                     return ;
//                                   }
//                                   _list.add(_enteredFirstSerial);
//                                   _serialList.add(_enteredFirstSerial);
//                                   serialMap['serial ${ind}']=value!;
//                                   setState(() {
//
//                                   });
//                                 },
//                                 onChanged: (v){
//                                   if(v!.isEmpty ||v!.length<1){
//                                     return ;
//                                   }
//                                   _list.add(_enteredFirstSerial);
//                                   _serialList.add(_enteredFirstSerial);
//                                   serialMap['serial ${ind}']=v!;
//                                   if(v.trim().characters.length==13)
//                                     FocusScope.of(context).unfocus();
//                                 },
//                               ),
//                             ),
//                           );
//                         Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           width:double.infinity ,
//                           child: TextFormField(
//
//                             textInputAction: TextInputAction.done,
//                             focusNode: focusList[noOfSerials-1],
//                             autofocus: true,
//                             decoration: InputDecoration(label: Text('serial'),
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(width: 3 , color: Colors.blue)
//                               ),
//                             ),
//                             onSaved: (value){
//                               setState(() {
//                                 _list.add(_enteredFirstSerial);
//                                 _serialList.add(_enteredFirstSerial);
//                                 serialMap['serial ${ind}']=value!;
//                               });
//                             },
//                             onChanged: (v){
//                               if(v.trim().characters.length==13)
//                                 FocusScope.of(context).unfocus();
//                             },
//                           ),
//                         );
//                       }
//                       return Container(
//                         margin: EdgeInsets.only(top: 5 , bottom: 5),
//                         width:width*80/100 ,
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: TextFormField(
//                             focusNode: focusList[ind],
//                             // autofocus: true,
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                 borderRadius: BorderRadius.circular(50.0),
//                               ),
//                               filled: true,
//                               alignLabelWithHint: false,
//
//                               label: Text('سيريال رقم${ind+1}',
//                                 style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                 Colors.black), textAlign: TextAlign.right,),
//                               fillColor: Colors.black.withOpacity(0.1),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                 borderRadius: BorderRadius.circular(50.0),
//                               ),
//                             ),
//                             onSaved: (value){
//                               if(value!.isEmpty ||value!.length<1){
//                                 return ;
//                               }
//                               _list.add(_enteredFirstSerial);
//                               _serialList.add(_enteredFirstSerial);
//                               serialMap['serial ${ind}']=value!;
//                               setState(() {
//
//                               });
//                             },
//                             onChanged: (v){
//                               if(v!.isEmpty ||v!.length<1){
//                                 return ;
//                               }
//                               _list.add(_enteredFirstSerial);
//                               _serialList.add(_enteredFirstSerial);
//                               serialMap['serial ${ind}']=v!;
//                               if(v.trim().characters.length==13)
//                               {
//                                 focusNode: focus;
//                                 // TextInputAction.next ;
//                                 FocusScope.of(context).requestFocus(focusList[ind+1]);
//                               }
//                             },
//                           ),
//                         ),
//                       );
//                     }) ,
//                   ),
//                   // Expanded(
//                   //   child: ListView.builder(
//                   //       shrinkWrap: true,
//                   //       itemCount:noOfSerials ,
//                   //       itemBuilder: (context , ind){
//                   //         if(ind == noOfSerials-1){
//                   //           return
//                   //             Container(
//                   //               width:width*75/100 ,
//                   //               child: Directionality(
//                   //                 textDirection: TextDirection.rtl,
//                   //                 child: TextFormField(
//                   //                   textInputAction: TextInputAction.done,
//                   //                   focusNode: focusList[noOfSerials-1],
//                   //                   autofocus: true,
//                   //                   decoration: InputDecoration(
//                   //                     focusedBorder: OutlineInputBorder(
//                   //                       borderSide:
//                   //                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                   //                       borderRadius: BorderRadius.circular(50.0),
//                   //                     ),
//                   //                     filled: true,
//                   //                     alignLabelWithHint: false,
//                   //
//                   //                     label: Text('سيريال رقم${ind}',
//                   //                       style: TextStyle(fontWeight: FontWeight.bold ,color:
//                   //                       Colors.black), textAlign: TextAlign.right,),
//                   //                     fillColor: Colors.black.withOpacity(0.1),
//                   //                     enabledBorder: OutlineInputBorder(
//                   //                       borderSide:
//                   //                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                   //                       borderRadius: BorderRadius.circular(50.0),
//                   //                     ),
//                   //                   ),
//                   //                   onSaved: (value){
//                   //                     setState(() {
//                   //                       _list.add(_enteredFirstSerial);
//                   //                       _serialList.add(_enteredFirstSerial);
//                   //                       serialMap['serial ${ind}']=value!;
//                   //                     });
//                   //                   },
//                   //                   onChanged: (v){
//                   //                     if(v.trim().characters.length==13)
//                   //                       FocusScope.of(context).unfocus();
//                   //                   },
//                   //                 ),
//                   //               ),
//                   //             );
//                   //             Container(
//                   //             margin: EdgeInsets.only(bottom: 10),
//                   //             width:double.infinity ,
//                   //             child: TextFormField(
//                   //
//                   //               textInputAction: TextInputAction.done,
//                   //               focusNode: focusList[noOfSerials-1],
//                   //               autofocus: true,
//                   //               decoration: InputDecoration(label: Text('serial'),
//                   //                 border: OutlineInputBorder(
//                   //                     borderSide: BorderSide(width: 3 , color: Colors.blue)
//                   //                 ),
//                   //               ),
//                   //               onSaved: (value){
//                   //                 setState(() {
//                   //                   _list.add(_enteredFirstSerial);
//                   //                   _serialList.add(_enteredFirstSerial);
//                   //                   serialMap['serial ${ind}']=value!;
//                   //                 });
//                   //               },
//                   //               onChanged: (v){
//                   //                 if(v.trim().characters.length==13)
//                   //                   FocusScope.of(context).unfocus();
//                   //               },
//                   //             ),
//                   //           );
//                   //         }
//                   //         return Container(
//                   //           margin: EdgeInsets.only(top: 5 , bottom: 5),
//                   //           width:width*80/100 ,
//                   //           child: Directionality(
//                   //             textDirection: TextDirection.rtl,
//                   //             child: TextFormField(
//                   //               focusNode: focusList[ind],
//                   //               // autofocus: true,
//                   //               decoration: InputDecoration(
//                   //                 focusedBorder: OutlineInputBorder(
//                   //                   borderSide:
//                   //                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                   //                   borderRadius: BorderRadius.circular(50.0),
//                   //                 ),
//                   //                 filled: true,
//                   //                 alignLabelWithHint: false,
//                   //
//                   //                 label: Text('سيريال رقم${ind}',
//                   //                   style: TextStyle(fontWeight: FontWeight.bold ,color:
//                   //                   Colors.black), textAlign: TextAlign.right,),
//                   //                 fillColor: Colors.black.withOpacity(0.1),
//                   //                 enabledBorder: OutlineInputBorder(
//                   //                   borderSide:
//                   //                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                   //                   borderRadius: BorderRadius.circular(50.0),
//                   //                 ),
//                   //               ),
//                   //               onSaved: (value){
//                   //                 setState(() {
//                   //                   _list.add(_enteredFirstSerial);
//                   //                   _serialList.add(_enteredFirstSerial);
//                   //                   serialMap['serial ${ind}']=value!;
//                   //                 });
//                   //               },
//                   //               onChanged: (v){
//                   //                 if(v.trim().characters.length==13)
//                   //                 {
//                   //                   focusNode: focus;
//                   //                   // TextInputAction.next ;
//                   //                   FocusScope.of(context).requestFocus(focusList[ind+1]);
//                   //                 }
//                   //               },
//                   //             ),
//                   //           ),
//                   //         );
//                   //           Container(
//                   //           margin: EdgeInsets.only(bottom: 10),
//                   //           width:double.infinity ,
//                   //           child: TextFormField(
//                   //             focusNode: focusList[ind],
//                   //             // autofocus: true,
//                   //             decoration: InputDecoration(label: Text('serial'),
//                   //               border: OutlineInputBorder(
//                   //                   borderSide: BorderSide(width: 3 , color: Colors.blue)
//                   //               ),
//                   //             ),
//                   //             onSaved: (value){
//                   //               setState(() {
//                   //                 _list.add(_enteredFirstSerial);
//                   //                 _serialList.add(_enteredFirstSerial);
//                   //                 serialMap['serial ${ind}']=value!;
//                   //               });
//                   //             },
//                   //             onChanged: (v){
//                   //               if(v.trim().characters.length==13)
//                   //               {
//                   //                 focusNode: focus;
//                   //                 // TextInputAction.next ;
//                   //                 FocusScope.of(context).requestFocus(focusList[ind+1]);
//                   //               }
//                   //             },
//                   //           ),
//                   //         );
//                   //       }),
//                   // ),
//                 //       TextFormField(
//                 //         decoration: InputDecoration(label: Text('bill Number'),
//                 //         ),
//                 //         onSaved: (value){
//                 //           _enteredFirstSerial = value!;
//                 //           setState(() {
//                 //             _list.add(_enteredFirstSerial);
//                 //             _serialList.add(_enteredFirstSerial);
//                 //             serialMap['_enteredFirstSerial']=_enteredFirstSerial;
//                 //
//                 //           });
//                 //         },
//                 //       ),
//                 //       TextFormField(
//                 //         decoration: InputDecoration(label: Text('bill Number'),
//                 //         ),
//                 //         onSaved: (value){
//                 //           _enteredSecondSerial = value!;
//                 //           setState(() {
//                 //             _list.add(_enteredSecondSerial);
//                 //             _serialList.add(_enteredSecondSerial);
//                 //             serialMap['_enteredSecondSerial']=_enteredSecondSerial;
//                 //
//                 //           });
//                 //         },
//                 //       ),
//                 //       TextFormField(
//                 //   decoration: InputDecoration(label: Text('serial'),
//                 //   ),
//                 //   onSaved: (value){
//                 //     _enteredThhirdSerial = value!;
//                 //     setState(() {
//                 //       _list.add(_enteredSecondSerial);
//                 //       _serialList.add(_enteredThhirdSerial);
//                 //       serialMap['_enteredThhirdSerial']=_enteredThhirdSerial;
//                 //
//                 //     });
//                 //   },
//                 // ),
//
//               ],),
//           ),
//         ),
//       ),
//     );
//   }
// }
