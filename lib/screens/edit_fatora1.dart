// import 'package:flutter/material.dart';
// import 'package:invoice/dummy_data/Bill_Model.dart';
// import 'package:invoice/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'dart:io';
//
// import '../dummy_data/file_storage.dart';
//
// class EditFatora1 extends StatefulWidget {
//   SharedPreferences? sharedPreferences;
//   final BillTextModel billTextModel;
//   final int currentIndex;
//   int numberOfSerials;
//   EditFatora1({this.sharedPreferences ,required this.billTextModel ,required
//   this.currentIndex ,  this.numberOfSerials=0});
//
//   @override
//   State<EditFatora1> createState() => _EditFatora1State();
// }
//
// class _EditFatora1State extends State<EditFatora1> {
//
//   List<BillTextModel>  myBills= List.empty(growable:true );
//   Map<String,String> _map={};
//   Map<String,String> serialMap={};
//   late SharedPreferences sp;
//   // getSharedPrefrences() async {
//   //   sp = await SharedPreferences.getInstance();
//   //   readFromSp();
//   //
//   // }
//
//
//   void save(){
//     List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
//     widget.sharedPreferences!.setStringList('myBills', myBillsStringList);
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
//
//   }
//   @override
//   void initState() {
//     super.initState();
//     read();
//   }
//   // void saveToSp(){
//   //   List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
//   //   sp.setStringList('myBills', myBillsStringList);
//   // }
//   //
//   // void readFromSp(){
//   //   List<String>? myBillsStringList = sp.getStringList('myBills');
//   //   if(myBillsStringList!=null)
//   //   {
//   //     myBills = myBillsStringList.map((billString) => BillTextModel.fromJson(
//   //         json.decode(billString))).toList();
//   //   }
//   //   setState(() {
//   //
//   //   });
//   // }
//   Future<void> _createTextFile({ required String name
//     ,  BillTextModel? billTextModel}) async {
//     _saveItem( );
//     // Map<String,String> _map= {
//     //   'id':billTextModel!.id,
//     //    'billType':billTextModel.billType.toString() ,
//     //     'serialList':billTextModel.serialMap.toString()
//     // };
//     FileStorage.writeCounter(
//         _map.toString(), "$name.txt");
//   }
//
//   void _saveItem(  ){
//
//     _map= {
//       'id':widget.billTextModel.id,
//       'enteredfileName':  widget.billTextModel.fileName,
//       'billType':widget.billTextModel.billType.toString() ,
//       'billNumber':widget.billTextModel.billNumber,
//       'itemNumber':widget.billTextModel.itemNumber,
//       'serialList':widget.billTextModel.serialMap.toString()
//     };
//
//     // saveToSp();
//
//
//   }
//   _createTextFile2 ({required Map<String,String> map ,required String name
//     ,  BillTextModel? billTextModel})  {
//
//     // _formKey.currentState!.save();
//     List<String> list =[];
//     map.forEach((key, value) { list.add(value);});
//     list.map((e) => {"" :  ""});
//     BillTextModel    billTextModel1=BillTextModel(id: DateTime.now().toString(), path: '',
//         fileName: billTextModel!.fileName,
//         billType: billTextModel!.billType,
//         billNumber: billTextModel!.billNumber,
//         itemNumber: billTextModel!.itemNumber,
//         serialMap:list, branchNumber: '');
//
//     _map= {
//       'File Name': billTextModel!.fileName ,
//       'Bill Type':billTextModel!.billType.toString() ,
//       'Bill Number':billTextModel!.billNumber,
//       'Item Number':billTextModel!.itemNumber,
//       'Serials':billTextModel!.serialMap.toString()
//     };
//     var concatenate = StringBuffer();
//
//     billTextModel!.serialMap.forEach((item){
//       concatenate.write('\n serial ${billTextModel!.serialMap.indexOf(item)+1} : $item \n');
//     });
//     final String content= 'Bill Type : ${billTextModel!.billType.toString()}  \n'
//         'Bill Number: ${billTextModel!.billNumber} \n '
//         'Item Number : ${billTextModel!.itemNumber} \n'
//         'Serials : $concatenate '  ;
//
//
//     FileStorage.writeCounter(
//         content, "$name.txt").then((file) {
//       List<String> list =[];
//       map.forEach((key, value) { list.add(value);});
//       list.map((e) => {"" :  ""});
//       // myBills[widget.currentIndex].path=file.path;
//       // myBills[widget.currentIndex].id=DateTime.now().toString();
//       //
//       // myBills[widget.currentIndex].billNumber=widget.billTextModel.billNumber;
//       // myBills[widget.currentIndex].fileName=widget.billTextModel.fileName;
//       // myBills[widget.currentIndex].itemNumber=widget.billTextModel.itemNumber;
//       // myBills[widget.currentIndex].billType =widget.billTextModel.billType;
//       // if(addListTextField == true){
//       //   myBills[widget.currentIndex].serialMap=list;
//       // }if(addListTextField ==false){
//       //   myBills[widget.currentIndex].serialMap=myBills[widget.currentIndex].serialMap;
//       // }
//       // billTextModel=BillTextModel(id: DateTime.now().toString(), path:value.path, fileName: enteredfileName,
//       //     billType: _enteredBillType,
//       //     billNumber: _enteredBillNumber,
//       //     itemNumber: entereditemNumber, serialMap:list);
//       // myBills.add(billTextModel!);
//       save();
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.blue, width: 2),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         backgroundColor: Colors.blue,
//         duration: Duration(milliseconds: 2000),
//         dismissDirection: DismissDirection.up,
//         content: Text('تم حفظ الفاتورة'
//           , style: TextStyle(color: Colors.white),) ,
//       ));
//       Navigator.pushReplacement(context, MaterialPageRoute(builder:
//           (context) {
//         return HomeScreen( sharedPreferences: widget.sharedPreferences,backAfterEdit: true,billLList: [],);
//       }
//       ));
//     });
//
//   }
//
//
//   List<TextEditingController>  textList=[];
//   var _billType=0;
//   var _billNumber='';
//   var _itemNumber='';
//
//   var x = 0;
//   var dropDownvalue=1;
//   var noOfSerials=0;
//   List<FocusNode> focusList=[];
//   final focus = FocusNode();
//   bool addListTextField=false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     noOfSerials=widget.billTextModel.serialMap.length;
//     print('noOfSerials $noOfSerials');
//     for(var i=0 ; i <widget.billTextModel.serialMap.length ;i++){
//       focusList.insert(i, FocusNode());
//
//     }
//     // var  lenght= 3+(widget.billTextModel.serialMap.length);
//     // var x = myBills.indexOf(widget.billTextModel);
//     x =   myBills.indexWhere((element) => widget.billTextModel.path ==element.path);
//     print('widget.numberOfSerials n build build ${widget.numberOfSerials}');
//     BillTextModel billTextModel = myBills[widget.currentIndex];
//     print('${widget.billTextModel.path}');
//     print('xx$x');
//     print('xx$x');
//     print('mybillslength ${myBills.length}');
//     print('${widget.billTextModel.path}');
//     // var y = myBills.indexOf(widget.billTextModel);
//     print('${myBills.indexOf(widget.billTextModel)}');
//     print('addListTextField ${addListTextField}');
//     // print('${myBills[y].path}');
//     //   print('my bILLLSlist ${myBills.length}');
//     // textList =List.generate(lenght, (index) => TextEditingController()) ;
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.green,
//         title: Center(
//           child: Text('تعديل فاتورة' , style: TextStyle(color: Colors.white ,
//             fontWeight: FontWeight.bold , ),
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () {
//             myBills[widget.currentIndex].id=DateTime.now().toString();
//
//             myBills[widget.currentIndex].billNumber=widget.billTextModel.billNumber;
//             myBills[widget.currentIndex].fileName=widget.billTextModel.fileName;
//             myBills[widget.currentIndex].itemNumber=widget.billTextModel.itemNumber;
//             myBills[widget.currentIndex].billType =widget.billTextModel.billType;
//             if(addListTextField== false){
//               myBills[widget.currentIndex].serialMap=widget.billTextModel.serialMap;
//             }
//             // // _saveItem();
//             if(addListTextField){
//               List<String> list =[];
//               serialMap.forEach((key, value) { list.add(value);});
//               list.map((e) => {"" :  ""});
//               myBills[widget.currentIndex].serialMap=list;
//             }
//             _createTextFile2( map: serialMap,name: widget.billTextModel.fileName ,
//                 billTextModel: widget.billTextModel);
//           }, child: Text('تعديل' , style:
//           TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
//               fontSize: 20),)
//           )
//         ],
//       ),
//       body: Form(
//         child: Container(
//           margin:EdgeInsets.all(10) ,
//           padding: EdgeInsets.only(left: 15 , right: 15),
//           child: SingleChildScrollView(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 10),
//                     width: width*80/100,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.black.withOpacity(0.1),
//                             boxShadow: [
//                               BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3),
//                             ],
//                           ),
//                           child:
//                           DropdownButton<int>(
//
//                             icon: Icon(Icons.arrow_drop_down_outlined),
//                             value: dropDownvalue,
//                             items:  [
//                               DropdownMenuItem(value: 1,
//                                 child: Text(widget.billTextModel.billType==1?'نقدى':'أجلة' ,
//                                   style: TextStyle(color: Colors.black
//                                       ,fontWeight: FontWeight.bold),) ,),
//                               DropdownMenuItem(value: 3,
//                                 child: Text(widget.billTextModel.billType==1?'أجلة':'نقدى' ,
//                                   style: TextStyle(color: Colors.black
//                                       ,fontWeight: FontWeight.bold),),),
//                             ],
//                             onChanged: (value) {
//                               dropDownvalue = value!;
//                               widget.billTextModel.billType =value;
//                               setState(() {
//
//                               });
//                             } ,
//                           ),
//
//                         ),
//                         SizedBox(width: 30,),
//
//                         Container(
//                           height: 40,
//                           width: width*30/100,
//                           child: Center(
//                             child: Text('نوع الفاتورة' ,style:
//                             TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),
//                                 textAlign: TextAlign.center),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.green,
//                             boxShadow: [
//                               BoxShadow(color: Colors.green, spreadRadius: 3),
//                             ],
//                           ), ),
//
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Container(
//                     width:width*80/100 ,
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: TextFormField(
//                         initialValue: widget.billTextModel.fileName,
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                           filled: true,
//                           alignLabelWithHint: false,
//
//                           label: Text('اسم الملف',
//                             style: TextStyle(fontWeight: FontWeight.bold ,color:
//                             Colors.black), textAlign: TextAlign.right,),
//                           fillColor: Colors.black.withOpacity(0.1),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                         ),
//                         validator: (value){
//                           if(value!.isEmpty ||value.length<1)
//                           {return ' please Enter Valid value' ;}
//                           else return null ;
//
//                         },
//                         onChanged: (x){
//                           print('${widget.billTextModel.path}');
//                           FileStorage.deleteFile(widget.billTextModel.path).then((value) {
//                             widget.billTextModel.fileName =x;
//                             setState(() {
//                             });
//                           }
//                           );
//
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Container(
//
//                     width:width*80/100 ,
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: TextFormField(
//                         initialValue: widget.billTextModel.billNumber,
//                         decoration: InputDecoration(
//
//
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                           filled: true,
//                           alignLabelWithHint: false,
//                           label: Text('رقم الفاتورة',
//                             style: TextStyle(fontWeight: FontWeight.bold ,color:
//                             Colors.black), textAlign: TextAlign.right,),
//                           fillColor: Colors.black.withOpacity(0.1),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                         ),
//                         onChanged: (value){
//                           setState(() {
//                             widget.billTextModel.billNumber =value;
//                           });
//
//                         },
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 10,),
//                   Container(
//
//                     width:width*80/100 ,
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         initialValue: widget.billTextModel.serialMap.length.toString(),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                           filled: true,
//                           alignLabelWithHint: false,
//                           label: Text('رقم الصنف',
//                             style: TextStyle(fontWeight: FontWeight.bold ,color:
//                             Colors.black), textAlign: TextAlign.right,),
//                           fillColor: Colors.black.withOpacity(0.1),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                         ),
//                         onChanged: (value){
//                           widget.numberOfSerials=int.parse(value);
//                           print('widget.numberOfSerials ${widget.numberOfSerials}');
//                           noOfSerials = int.parse(value);
//                           addListTextField=true;
//                           for(var i=0 ; i <widget.numberOfSerials ;i++){
//                             focusList.insert(i, FocusNode());
//                           }
//                           setState(() {
//
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   // serials
//                   Container(
//                     width:width*80/100 ,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width:width*25/100 ,
//                           child: Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: TextFormField(
//                               keyboardType: TextInputType.number,
//                               initialValue: widget.billTextModel.serialMap.length.toString(),
//                               decoration: InputDecoration(
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                                 filled: true,
//                                 alignLabelWithHint: false,
//                                 label: Text('عدد السيريال',
//                                   style: TextStyle(color:
//                                   Colors.black ,fontSize: 15), textAlign: TextAlign.right,),
//                                 fillColor: Colors.black.withOpacity(0.1),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                               ),
//
//                               onChanged: (value){
//                                 widget.numberOfSerials=int.parse(value);
//                                 print('widget.numberOfSerials ${widget.numberOfSerials}');
//                                 noOfSerials = int.parse(value);
//                                 addListTextField=true;
//                                 for(var i=0 ; i <widget.numberOfSerials ;i++){
//                                   focusList.insert(i, FocusNode());
//                                 }
//                                 setState(() {
//
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10,),
//
//                         Container(
//                           height: 40,
//                           width: width*50/100,
//                           child: Center(
//                             child: Text('عدد السيريال للاجهزة' ,style:
//                             TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),
//                                 textAlign: TextAlign.center),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.green,
//                             boxShadow: [
//                               BoxShadow(color: Colors.green, spreadRadius: 3),
//                             ],
//                           ), ),
//                       ],
//                     ),
//                   ),
//
//                   Column(children:
//                     List.generate(widget.numberOfSerials, (ind) {
//                       //if edit nhumber of serials for fatora
//                       if(widget.billTextModel.serialMap.length < widget.numberOfSerials)
//                         {
//                           if(ind == widget.numberOfSerials-1){
//                             return Container(
//                               width:width*75/100 ,
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: TextFormField(
//                                   initialValue:'' ,
//                                   textInputAction: TextInputAction.done,
//                                   focusNode: focusList[widget.numberOfSerials-1],
//                                   autofocus: true,
//                                   decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                     filled: true,
//                                     alignLabelWithHint: false,
//
//                                     label: Text('سيريال رقم${ind}',
//                                       style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                       Colors.black), textAlign: TextAlign.right,),
//                                     fillColor: Colors.black.withOpacity(0.1),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                   ),
//                                   onSaved: (value){
//                                     if(noOfSerials==0){
//
//                                     }
//                                     setState(() {
//
//                                       // widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                       serialMap['serial $ind']=value! ;
//
//                                     });
//                                   },
//                                   onChanged: (v){
//                                     setState(() {
//
//                                       // widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                       serialMap['serial $ind']=v! ;
//                                       // widget.billTextModel.serialMap![ind] =v;
//                                       if(v.trim().characters.length==13)
//                                         FocusScope.of(context).unfocus();
//
//                                     });
//
//                                   },
//                                 ),
//                               ),
//                             );
//                           }
//                           if(ind <widget.billTextModel.serialMap.length-2){
//                             return  Container(
//                               margin: EdgeInsets.only(top: 5 , bottom: 5),
//                               width:width*80/100 ,
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: TextFormField(
//                                   focusNode: focusList[ind],
//                                   initialValue:widget.billTextModel.serialMap![ind] ,
//                                   // autofocus: true,
//                                   // autofocus: true,
//                                   decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                     filled: true,
//                                     alignLabelWithHint: false,
//
//                                     label: Text('سيريال رقم${ind}',
//                                       style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                       Colors.black), textAlign: TextAlign.right,),
//                                     fillColor: Colors.black.withOpacity(0.1),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                   ),
//                                   onSaved: (value){
//                                     setState(() {
//                                       var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                       serialMap['serial $ind']=value! ;
//                                       widget.billTextModel.serialMap![ind] =value;
//                                     });
//                                   },
//                                   onChanged: (v){
//                                     if(v.trim().characters.length==13)
//                                     {
//                                       focusNode: focus;
//                                       // TextInputAction.next ;
//                                       serialMap['serial $ind']=v! ;
//                                       widget.billTextModel.serialMap![ind] =v;
//                                       FocusScope.of(context).requestFocus(focusList[ind+1]);
//                                     }
//                                   },
//                                 ),
//                               ),
//                             );
//                           }
//                           if(ind >widget.billTextModel.serialMap.length){
//                             return Container(
//                               width:width*75/100 ,
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: TextFormField(
//                                   initialValue:'' ,
//                                   textInputAction: TextInputAction.done,
//                                   focusNode: focusList[widget.numberOfSerials-1],
//                                   autofocus: true,
//                                   decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                     filled: true,
//                                     alignLabelWithHint: false,
//
//                                     label: Text('سيريال رقم${ind}',
//                                       style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                       Colors.black), textAlign: TextAlign.right,),
//                                     fillColor: Colors.black.withOpacity(0.1),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                   ),
//                                   onSaved: (value){
//                                     if(noOfSerials==0){
//
//                                     }
//                                     setState(() {
//
//                                       // widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                       serialMap['serial $ind']=value! ;
//
//                                     });
//                                   },
//                                   onChanged: (v){
//                                     setState(() {
//
//                                       // widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                       serialMap['serial $ind']=v! ;
//                                       // widget.billTextModel.serialMap![ind] =v;
//                                       if(v.trim().characters.length==13)
//                                         FocusScope.of(context).unfocus();
//
//                                     });
//
//                                   },
//                                 ),
//                               ),
//                             );
//                           }
//                         }
//                         if(ind == widget.numberOfSerials-1){
//                           return Container(
//                             width:width*75/100 ,
//                             child: Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: TextFormField(
//                                 initialValue:addListTextField ? '':widget.billTextModel.serialMap![ind] ,
//                                 textInputAction: TextInputAction.done,
//                                 focusNode: focusList[widget.numberOfSerials-1],
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
//                                 onSaved: (value){
//                                   setState(() {
//
//                                     // widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                     serialMap['serial $ind']=value! ;
//                                     widget.billTextModel.serialMap![ind] =value!;
//                                   });
//                                 },
//                                 onChanged: (v){
//                                   widget.billTextModel.serialMap![ind] =v;
//                                   serialMap['serial $ind']=v! ;
//
//                                   if(v.trim().characters.length==13)
//                                     FocusScope.of(context).unfocus();
//                                   setState(() {
//                                     // widget.billTextModel.serialMap.indexOf(serialMap[ind]!
//                                   });
//
//                                 },
//                               ),
//                             ),
//                           );
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(color: Colors.blue, spreadRadius: 3),
//                               ],
//                             ),
//                             margin: EdgeInsets.only(top :10 ,bottom: 10),
//                             width:double.infinity ,
//                             child: TextFormField(
//
//                               initialValue:addListTextField ? '0':widget.billTextModel.serialMap![ind] ,
//                               textInputAction: TextInputAction.done,
//                               focusNode: focusList[widget.numberOfSerials-1],
//                               autofocus: true,
//                               decoration: InputDecoration(label: Text('serial'),
//                               ),
//                               onSaved: (value){
//                                 if(noOfSerials==0){
//
//                                 }
//                                 setState(() {
//
//                                   var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                   serialMap['serial $i']=value! ;
//                                   widget.billTextModel.serialMap![i] =value;
//                                 });
//                               },
//                               onChanged: (v){
//                                 if(v.trim().characters.length==13)
//                                   FocusScope.of(context).unfocus();
//                               },
//                             ),
//                           );
//                         }
//                         return  Container(
//                           margin: EdgeInsets.only(top: 5 , bottom: 5),
//                           width:width*80/100 ,
//                           child: Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: TextFormField(
//                               focusNode: focusList[ind],
//                               initialValue:widget.billTextModel.serialMap![ind] ,
//                               // autofocus: true,
//                               // autofocus: true,
//                               decoration: InputDecoration(
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                                 filled: true,
//                                 alignLabelWithHint: false,
//
//                                 label: Text('سيريال رقم${ind+1}',
//                                   style: TextStyle(fontWeight: FontWeight.bold ,color:
//                                   Colors.black), textAlign: TextAlign.right,),
//                                 fillColor: Colors.black.withOpacity(0.1),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                               ),
//                               onSaved: (value){
//                                 setState(() {
//                                   var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                                   serialMap['serial $ind']=value! ;
//                                   widget.billTextModel.serialMap![ind] =value;
//                                 });
//                               },
//                               onChanged: (v){
//                                 widget.billTextModel.serialMap![ind] =v;
//                                 serialMap['serial $ind']=v! ;
//
//                                 if(v.trim().characters.length==13)
//                                 {
//                                   FocusScope.of(context).requestFocus(focusList[ind+1]);
//
//                                   setState(() {
//
//                                   });
//                                   focusNode: focus;
//                                   // TextInputAction.next
//                                 }
//                               },
//                             ),
//                           ),
//                         );
//
//                     }),),
//                   // Expanded(
//                   //   child:
//                   //   ListView.builder( itemCount:widget.numberOfSerials ,
//                   //       itemBuilder: (context , ind){
//                   //         if(ind == widget.numberOfSerials-1){
//                   //           return  Container(
//                   //             decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(10),
//                   //               color: Colors.white,
//                   //               boxShadow: [
//                   //                 BoxShadow(color: Colors.blue, spreadRadius: 3),
//                   //               ],
//                   //             ),
//                   //             margin: EdgeInsets.only(top :10 ,bottom: 10),
//                   //             width:double.infinity ,
//                   //             child: TextFormField(
//                   //
//                   //               initialValue:addListTextField ? '0':widget.billTextModel.serialMap![ind] ,
//                   //               textInputAction: TextInputAction.done,
//                   //               focusNode: focusList[widget.numberOfSerials-1],
//                   //               autofocus: true,
//                   //               decoration: InputDecoration(label: Text('serial'),
//                   //               ),
//                   //               onSaved: (value){
//                   //                 if(noOfSerials==0){
//                   //
//                   //                 }
//                   //                 setState(() {
//                   //
//                   //                   var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                   //                   serialMap['serial $i']=value! ;
//                   //                   widget.billTextModel.serialMap![i] =value;
//                   //                 });
//                   //               },
//                   //               onChanged: (v){
//                   //                 if(v.trim().characters.length==13)
//                   //                   FocusScope.of(context).unfocus();
//                   //               },
//                   //             ),
//                   //           );
//                   //         }
//                   //         return  Container(
//                   //           decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(10),
//                   //             color: Colors.white,
//                   //             boxShadow: [
//                   //               BoxShadow(color: Colors.blue, spreadRadius: 3),
//                   //             ],
//                   //           ),
//                   //           margin: EdgeInsets.only(bottom: 10 , top:10),
//                   //           width:double.infinity ,
//                   //           child: Container(
//                   //             child: TextFormField(
//                   //               initialValue:widget.billTextModel.serialMap![ind] ,
//                   //               focusNode: focusList[ind],
//                   //               // autofocus: true,
//                   //               decoration: InputDecoration(label: Text('serial'),
//                   //               ),
//                   //               onSaved: (value){
//                   //                 setState(() {
//                   //                   var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
//                   //                   serialMap['serial $i']=value! ;
//                   //                   widget.billTextModel.serialMap![i] =value;
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
//                   //       }),
//                   // ),
//                   // if(addListTextField==false)
//                   //   Expanded(
//                   //     child: ListView(
//                   //       children:widget.billTextModel.serialMap!.map((e) =>
//                   //           Container(
//                   //             margin: EdgeInsets.only(top:10 , bottom: 10),
//                   //             decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(10),
//                   //               color: Colors.white,
//                   //               boxShadow: [
//                   //                 BoxShadow(color: Colors.blue, spreadRadius: 3),
//                   //               ],
//                   //             ),
//                   //             child: TextFormField(initialValue:e ,
//                   //               onChanged: (value){
//                   //                 setState(() {
//                   //                   var i = widget.billTextModel.serialMap!.indexOf(e);
//                   //                   serialMap['serial $i']=value ;
//                   //                   widget.billTextModel.serialMap![i] =value;
//                   //                 });
//                   //
//                   //               },),
//                   //           )
//                   //       ).toList(),
//                   //     ),
//                   //   ),
//                 ]
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
