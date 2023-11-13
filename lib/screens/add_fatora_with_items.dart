import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:invoice/shared_preferences/shared_preferences.dart';
import 'package:invoice/widget/ListViewCard.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcell;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'package:path/path.dart' as pathP;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../dummy_data/Bill_Model.dart';
import '../dummy_data/dummy_data.dart';
import '../dummy_data/file_storage.dart';
import '../widget/drop_menu.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddFatoraWithItems extends StatefulWidget {
  SharedPreferences? sharedPreferences;

  AddFatoraWithItems({this.sharedPreferences});

  @override
  State<AddFatoraWithItems> createState() => _AddFatoraWithItemsState();
}

class _AddFatoraWithItemsState extends State<AddFatoraWithItems> {
  bool addedPath=false;
  final _formKey = GlobalKey<FormState>();
  final _formKeyDialog = GlobalKey<FormState>();
  List<String> itemsList=[];
  Map<String,String> serialMap={};
  Map<String,List<String>> itemswithSerial={};
  var _enteredBranchNumber='';
  var _enteredBillType=0;
  var entereditemNumber = '';
  var enteredfileName = '';
  var _enteredBillNumber = '';
  var _enteredFirstSerial = '';
  var _enteredSecondSerial = '';
  var _enteredThhirdSerial = '';
  bool addListTextField = false;
  BillTextModel? billTextModel;
  var filepath='';
  List<String> _list=['ahmed' , 'mmmmmm' ,'hhhhhhhh' ];
  static const myList = {
    "name":"GeeksForGeeks"
  };
  Map<String,String> _map={};

  List<BillTextModel>  myBills= [];


  var pppp='';
  var ssss='';
  void save(){
    List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
    widget.sharedPreferences!.setStringList('myBills', myBillsStringList);
    print('true or false ${widget.sharedPreferences!.setStringList('myBills', myBillsStringList)}}');

  }
  void read() {

    List<String>? myBillsStringList = widget.sharedPreferences!.getStringList('myBills');

    if(myBillsStringList!=null)
    {
      myBills =myBillsStringList.map((billString) => BillTextModel.fromJson(
          json.decode(billString))).toList();
    }

    setState(() {

    });
  }
  @override
  void initState() {
    // getSharedPrefrences();
    super.initState();
    // getSharedPrefrences();
    print('init state');

  }




  _createTextFile2 ({required Map<String,String> map ,required String name
    ,  BillTextModel? billTextModel1})  {
    if(_formKey.currentState!.validate())
    {
      _formKey.currentState!.save();
      List<String> list =[];
      map.forEach((key, value) { list.add(value);});
      list.map((e) => {"" :  ""});
      BillTextModel    billTextModel2=BillTextModel(
          billType: _enteredBillType,
          billNumber: _enteredBillNumber,
          serialMap:itemsList, branchNumber: _enteredBranchNumber);

      _map= {
        'Bill Type':billTextModel2!.billType.toString() ,
        'Bill Number':billTextModel2!.billNumber,
        'Serials':billTextModel2!.serialMap.toString()
      };
      var concatenateSerialList = StringBuffer();
      var  concatenateMybillsList= StringBuffer();
      
      billTextModel2!.serialMap.forEach((item){
        concatenateSerialList.write('\n${ item.contains('Item') ?'Item name ${item.substring(6)}' :
        'serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n'}  ');
            // 'serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n');
      });
      final String content= 'Bill Type : ${billTextModel2!.billType.toString()}  \n'
          'Bill Number: ${billTextModel2!.billNumber} \n '
          'Serials : $concatenateSerialList '  ;
      var newContent='';

      billTextModel=BillTextModel(
          billType: _enteredBillType,
          billNumber: _enteredBillNumber,
           serialMap:sanfList1, branchNumber: _enteredBranchNumber);
      myBills.add(billTextModel!);
      myBills.forEach((element) {
        element.serialMap.forEach((item){
          concatenateSerialList.write('\n${ item.contains('Item') ?'Item name ${item.substring(6)}' :
          'serial ${element!.serialMap.indexOf(item)+1} : $item \n'}');
          // 'serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n');
        });
        var list = ['one', 'two', 'three'];
        var concatenate = StringBuffer();
        list.forEach((item){
          concatenate.write(item);
        });

        List<StringBuffer> bufferList=[];

        for(var i=0 ;i<myBills.length;i++){
          bufferList.insert(i, StringBuffer());
          List sanfList=[];
          element.serialMap.forEach((item) {
            // if(item.contains('sanf')){
            //   sanfList.add(item);
            // }
            //
            // print('sanfList $sanfList');
            //         sanfList.forEach((sanf) {
            //           if((sanf.toString() != item.toString()) ){
            //             bool x=(sanf.trim() == item.trim());
            //             print(x);
            //             bufferList[i].write('${element!.branchNumber},${element.billType.toString()},'
            //                 '${element!.billNumber},$sanf, $item \n');
            //
            //           }
            //         }) ;
            //
            //         for(var x=0; x<element.serialMap.length;x++){
            //
            //         }
            if(item.contains('sanf')==false){
              bufferList[i].write('${element!.branchNumber},${element.billType.toString()},'
                  '${element!.billNumber}, $item \n');
            }

            // bufferList[i].write(item.contains('sanf') ?'${item.substring(5)},' : '$item,');
            // bufferList[i].write('$item,');
          });
        }


        // concatenateMybillsList.write('Bill Type : ${element.billType.toString()}  \n'
        //     'Bill Number: ${element!.billNumber} \n '
        //     'Branch Number : ${element!.branchNumber} \n'
        //     'Serials : ${element.serialMap.toString()} \n' )  ;
        // concatenateMybillsList.write('$bufferList');
        concatenateMybillsList.write('${bufferList[myBills.indexOf(element)]} \n');
        // concatenateMybillsList.write('${element!.branchNumber},${element.billType.toString()},'
        //     '${element!.billNumber}, ${bufferList[myBills.indexOf(element)]} \n');
        newContent=concatenateMybillsList.toString() ;
      });
      save();
      FileStorage.writeCounter(
          newContent, "Fatora.txt").then((value) {
        List<String> list =[];
        map.forEach((key, value) { list.add(value);});
        list.map((e) => {"" :  ""});

        widget.sharedPreferences!.setString('lastPath', value.path);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.blue,
          duration: Duration(milliseconds: 2000),
          dismissDirection: DismissDirection.up,
          content: Text('تم حفظ الفاتورة'
            , style: TextStyle(color: Colors.white),) ,
        ));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomeScreen( sharedPreferences: widget.sharedPreferences,
            backAfterAddBill: true, billLList: [],);
        }));
      });
    }


  }

  void _saveItem(Map<String,String> map , String path  ){

    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      List<String> list =[];
      map.forEach((key, value) { list.add(value);});
      list.map((e) => {"" :  ""});
      billTextModel=BillTextModel(
          billType: _enteredBillType,
          billNumber: _enteredBillNumber,
           serialMap:list, branchNumber: _enteredBranchNumber);
      myBills.add(billTextModel!);
      save();
    }

    // List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
    // sp.setStringList('myBills', myBillsStringList);
    // saveToSp();
    // _map= billTextModel!.toJson() as Map<String ,String>;
    // _map= {
    //   'id':billTextModel!.id,
    //   'path':path,
    //   'enteredfileName': billTextModel!.fileName ,
    //   'billType':billTextModel!.billType.toString() ,
    //   'billNumber':billTextModel!.billNumber,
    //   'itemNumber':billTextModel!.itemNumber,
    //   'serialList':billTextModel!.serialMap.toString()
    // };
    // BillModel billModel = BillModel.fromJson(json);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) {
    //       return HomeScreen(billNumber:_enteredBillNumber ,
    //         firstSerial: _enteredFirstSerial,
    //         secondSerial: _enteredSecondSerial,
    //       );
    //     })
    // );
  }
  var dropDownvalue=1;
  var noOfSerials=0;
  var noOfSerials1=0;
  List<FocusNode> focusList=[];
  final focus = FocusNode();
  List<FocusNode> focusListDialog=[];
  final focusDialog = FocusNode();
  var itemsNumber=0;
  bool addItems=false;
  var sanfName='';
  void refresh() {
    setState(() {});
  }

  List<String>   sanfList1=[];

  Map<String,int> sanfMap={};
  
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    _enteredBillType=dropDownvalue;

    // list.add(_enteredBillNumber);
    print('widget.sharedPreferences ${widget.sharedPreferences}');

    // print('ssss ${ssss}');

    print(serialMap.toString());
    read();
    print('myBIlls${myBills.length}');
    print('myBIlls${widget.sharedPreferences!.getStringList('myBills')}');
    // print('${map['_enteredFirstSerial']}');
    // BillTextModel _myTextMapList = BillTextModel(1 , 'bill', map) ;

    List<String> _serialList = [];
    print('billTextModel${billTextModel?.billNumber.toString()}');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        title: Center(
          child: Text('اضافة فاتورة' , style: TextStyle(color: Colors.white ,
            fontWeight: FontWeight.bold , ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            // _createTextFile(map: map , name: '$enteredfileName'
            //     , billTextModel1:  billTextModel);
            // List<String> list1 =[];
            // map.forEach((keymn, value) { list1.add(value);});
            // list1.map((e) => {"" :  ""});
            _createTextFile2(map: serialMap ,name: '$enteredfileName');

          },
              child: Text('حفظ' ,style:
              TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
                  fontSize: 20),))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Container(
            margin:EdgeInsets.all(10) ,
            padding: EdgeInsets.only(left: 15 , right: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: width*80/100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black.withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3),
                            ],
                          ),
                          child:
                          DropdownButton<int>(
                            padding: EdgeInsets.all(5),
                            hint: Text('نوع الفاتورة', style: TextStyle(color: Colors.black
                                ,fontWeight: FontWeight.bold
                            ),),
                            icon: Icon(Icons.arrow_drop_down_outlined),
                            value: dropDownvalue,
                            items: const [
                              DropdownMenuItem(value: 1,
                                child: Text('نقدى' ,
                                  style: TextStyle(color: Colors.black
                                      ,fontWeight: FontWeight.bold),) ,),
                              DropdownMenuItem(value: 3,
                                child: Text('أجلة' ,
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) ,),
                            ],
                            onChanged: (value) {
                              dropDownvalue = value!;
                              _enteredBillType =value;
                              setState(() {

                              });
                            } ,
                          ),

                        ),
                        SizedBox(width: 30,),

                        Container(
                          height: 40,
                          width: width*30/100,
                          child: Center(
                            child: Text('نوع الفاتورة' ,style:
                            TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),
                                textAlign: TextAlign.center),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ), ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width:width*80/100 ,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          alignLabelWithHint: false,

                          label: Text('رقم الفرع',
                            style: TextStyle(fontWeight: FontWeight.bold ,color:
                            Colors.black), textAlign: TextAlign.right,),
                          fillColor: Colors.black.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty ||value.length<1)
                          {return ' please Enter Valid value' ;}
                          else return null ;

                        },
                        onSaved: (value){
                          _enteredBranchNumber =  value!;
                          setState(() {
                            _list.add(_enteredBranchNumber.toString());
                            // _serialList.add(_enteredBillNumber);
                            // map['_enteredBillType']=_enteredBillType.toString();

                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _enteredBranchNumber=value;

                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(

                    width:width*80/100 ,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          alignLabelWithHint: false,
                          label: Text('رقم الفاتورة',
                            style: TextStyle(fontWeight: FontWeight.bold ,color:
                            Colors.black), textAlign: TextAlign.right,),
                          fillColor: Colors.black.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            _enteredBillNumber = value!;
                          });
                        },
                        onSaved: (value){

                          setState(() {
                            _enteredBillNumber = value!;
                            _list.add(_enteredBillNumber);
                            // _serialList.add(_enteredBillNumber);
                            //  map['_enteredBillNumber']=_enteredBillNumber;

                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),

                  //items first
                   Container(width: width*70/100,
                   child: Directionality(
                     textDirection: TextDirection.rtl,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         TextButton(
                             onPressed: () async
                         {
                                await showDialog(context: context, builder: (context){
                                   return StatefulBuilder(
                                     builder: (context,setState)=>
                                         Form(
                                           key: _formKeyDialog,
                                           child: AlertDialog(

                                             title: Container(
                                               width: width*80/100,
                                               child: Directionality(
                                                 textDirection: TextDirection.rtl,
                                                 child: TextFormField(
                                                   textInputAction: TextInputAction.next,
                                                   decoration: InputDecoration(
                                                     focusedBorder: OutlineInputBorder(
                                                       borderSide:
                                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                       borderRadius: BorderRadius.circular(50.0),
                                                     ),
                                                     filled: true,
                                                     alignLabelWithHint: false,
                                                     label: Text('كود الصنف',
                                                       style: TextStyle(fontWeight: FontWeight.bold ,color:
                                                       Colors.black), textAlign: TextAlign.right,),
                                                     fillColor: Colors.black.withOpacity(0.1),
                                                     enabledBorder: OutlineInputBorder(
                                                       borderSide:
                                                       BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                       borderRadius: BorderRadius.circular(50.0),
                                                     ),
                                                   ),
                                                   onSaved: (value){
                                                     if(value!.isNotEmpty &&value!.length>0)
                                                       {
                                                         sanfName=value;
                                                         itemsList.add('sanf $value');
                                                         sanfList1.add('sanf, $value');

                                                         // if(itemsList.isNotEmpty){
                                                         //
                                                         // }
                                                         // if(itemsList.isEmpty){
                                                         //   itemsList.insert(0 , 'sanf0 $value');
                                                         // }
                                                       }


                                                   },
                                                   onChanged: (value){

                                                   },
                                                 ),
                                               ),
                                             ),
                                             content: SingleChildScrollView(
                                               child: Column(
                                                 children: [
                                                   Container(
                                                     margin: EdgeInsets.all(5),
                                                     width: width*70/100,
                                                     child: Directionality(
                                                       textDirection: TextDirection.rtl,
                                                       child: TextFormField(
                                                         textInputAction: TextInputAction.next,
                                                         decoration: InputDecoration(
                                                           focusedBorder: OutlineInputBorder(
                                                             borderSide:
                                                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                             borderRadius: BorderRadius.circular(50.0),
                                                           ),
                                                           filled: true,
                                                           alignLabelWithHint: false,
                                                           label: Text('عدد السيريال',
                                                             style: TextStyle(fontWeight: FontWeight.bold ,color:
                                                             Colors.black), textAlign: TextAlign.right,),
                                                           fillColor: Colors.black.withOpacity(0.1),
                                                           enabledBorder: OutlineInputBorder(
                                                             borderSide:
                                                             BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                             borderRadius: BorderRadius.circular(50.0),
                                                           ),
                                                         ),
                                                         onChanged: (value){
                                                           noOfSerials1=int.parse(value);
                                                           sanfMap[sanfName]= int.parse(value);
                                                           for(var i=0 ; i <noOfSerials1 ;i++){
                                                             focusListDialog.insert(i, FocusNode());
                                                           }
                                                           setState(() {

                                                           });
                                                         },
                                                       ),
                                                     ),
                                                   ),
                                                   if(noOfSerials1>0)
                                                     Column(children: List.generate(noOfSerials1, (index) {
                                                       if(index == noOfSerials1-1)
                                                         {return Container(
                                                           margin: EdgeInsets.all(5),
                                                           width: width*80/100,
                                                           child: Directionality(
                                                             textDirection: TextDirection.rtl,
                                                             child: TextFormField(
                                                               textInputAction: TextInputAction.done,
                                                               focusNode: focusListDialog[noOfSerials1-1],
                                                               decoration: InputDecoration(
                                                                 focusedBorder: OutlineInputBorder(
                                                                   borderSide:
                                                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                                   borderRadius: BorderRadius.circular(50.0),
                                                                 ),
                                                                 filled: true,
                                                                 alignLabelWithHint: false,
                                                                 label: Text('سيريال رقم ${index+1}',
                                                                   style: TextStyle(fontWeight: FontWeight.bold ,color:
                                                                   Colors.black), textAlign: TextAlign.right,),
                                                                 fillColor: Colors.black.withOpacity(0.1),
                                                                 enabledBorder: OutlineInputBorder(
                                                                   borderSide:
                                                                   BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                                   borderRadius: BorderRadius.circular(50.0),
                                                                 ),
                                                               ),
                                                               validator: (value){
                                                                 if(value!.isNotEmpty && value!.length>0){
                                                                   return null;
                                                                 }
                                                                 return'please enter a valid value';
                                                               }
                                                               ,
                                                               onSaved: (value){
                                                                 itemsList.add('$value');
                                                                 sanfList1.add('$sanfName, $value');
                                                                 // if(value!.isNotEmpty && value!.length>0)
                                                                 //   itemsList.add(value!);

                                                               },
                                                               onChanged: (value){
                                                                 if(value.trim().characters.length==13)
                                                                 {
                                                                   focusNode: focus;
                                                                   // TextInputAction.next ;
                                                                   FocusScope.of(context).nearestScope;

                                                                 }
                                                               },

                                                             ),
                                                           ),
                                                         ) ;}
                                                       return Container(
                                                         margin: EdgeInsets.all(5),
                                                         width: width*80/100,
                                                         child: Directionality(
                                                           textDirection: TextDirection.rtl,
                                                           child: TextFormField(
                                                             textInputAction: TextInputAction.next,
                                                             focusNode: focusListDialog[index],
                                                             decoration: InputDecoration(
                                                               focusedBorder: OutlineInputBorder(
                                                                 borderSide:
                                                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                                 borderRadius: BorderRadius.circular(50.0),
                                                               ),
                                                               filled: true,
                                                               alignLabelWithHint: false,
                                                               label: Text('سيريال رقم ${index+1}',
                                                                 style: TextStyle(fontWeight: FontWeight.bold ,color:
                                                                 Colors.black), textAlign: TextAlign.right,),
                                                               fillColor: Colors.black.withOpacity(0.1),
                                                               enabledBorder: OutlineInputBorder(
                                                                 borderSide:
                                                                 BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                                                 borderRadius: BorderRadius.circular(50.0),
                                                               ),
                                                             ),
                                                             validator: (value){
                                                               if(value!.isNotEmpty && value!.length>0){
                                                                 return null;
                                                               }
                                                               return'please enter a valid value';
                                                             }
                                                             ,
                                                             onSaved: (value){
                                                               itemsList.add('$value');
                                                               sanfList1.add('$sanfName, $value');
                                                               // if(value!.isNotEmpty && value!.length>0)
                                                               // itemsList.add(value!);

                                                             },
                                                             onChanged: (value){
                                                               if(value.trim().characters.length==13)
                                                               {
                                                                 focusNode: focus;
                                                                 // TextInputAction.next ;
                                                                 FocusScope.of(context).requestFocus(focusListDialog[index+1]);
                                                               }
                                                             },

                                                           ),
                                                         ),
                                                       ) ;
                                                     }),)
                                                 ],
                                               ),
                                             ),
                                             actions: [
                                               TextButton(onPressed:() {
                                                 if(_formKeyDialog.currentState!.validate()){
                                                   _formKeyDialog.currentState!.save();
                                                   Navigator.of(context).pop();
                                                 }

                                               }, child: Text('حفظ'))
                                             ],
                                           ),
                                         ),

                                   );
                                 });
                                setState(() {

                                });
                         }, child: Container(
                           padding:EdgeInsets.all(5) ,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                             color: Colors.green,
                             boxShadow: [
                               BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3),
                             ],
                           ),
                                child: Text('اضافة صنف جديد' ,style: TextStyle(
                             fontWeight: FontWeight.bold ,fontSize: 15,color: Colors.white
                           ),),
                         )),
                         SizedBox(width: 10,),
                       ],
                     ),
                   ),),
                  SizedBox(height: 10,),
                  if(itemsList.length>0)
                    Column(children: List.generate(itemsList.length, (index) {

                      // return ListViewCard(index, Key('${itemsList[index]}'), itemsList, refresh , width);
                      for(var i=0 ; i <itemsList.length ;i++){
                        focusList.insert(i, FocusNode());
                      }
                      if(index == itemsList.length-1){
                        return Container(
                          key:ValueKey('${itemsList[index]}'),
                          margin: EdgeInsets.all(5),
                          width: width*80/100,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: width*60/100,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    initialValue:itemsList[index].contains('sanf') ?
                                    itemsList[index].substring(5):
                                    itemsList[index],

                                    decoration: InputDecoration(

                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      filled: true,
                                      alignLabelWithHint: false,
                                      label: Text((itemsList[index].startsWith('sanf'))?'كود الصنف':'سيريال ',
                                        style: TextStyle(fontWeight: FontWeight.bold ,
                                            color:itemsList[index].startsWith('sanf') ? Colors.black:
                                            Colors.black), textAlign: TextAlign.right,),
                                      fillColor: itemsList[index].startsWith('sanf') ?Colors.green :
                                      Colors.black.withOpacity(0.1),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    focusNode: focusList[itemsList.length-1],
                                    onChanged: (value){
                                      if(value!.isNotEmpty && value.length>0){
                                        var x=sanfList1[index].substring(0 , sanfList1[index].indexOf(',')+1);
                                        sanfList1[index]= '$x $value';
                                        if(itemsList[index].contains("sanf")){
                                          itemsList[index]="sanf ${value}";
                                        }
                                        if( !itemsList[index].contains("sanf")){
                                          itemsList[index]=value;
                                        }
                                      }

                                      if(value.trim().characters.length==13)
                                        FocusScope.of(context).unfocus();
                                    },
                                    onSaved: (v){

                                      if(v!.isNotEmpty && v.length>0){
                                        var x=sanfList1[index].substring(0 , sanfList1[index].indexOf(',')+1);
                                        sanfList1[index]= '$x $v';
                                        if(itemsList[index].contains("sanf")){
                                          itemsList[index]="sanf ${v}";
                                        }if(!itemsList[index].contains("sanf")){
                                          itemsList[index]=v;
                                        }
                                        serialMap['${index}']=v!;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  width: width*20/100,
                                  child: IconButton(onPressed: (){
                                          // print('index$index');
                                          // print('sanfMap[itemsList[index]${sanfMap[itemsList[index]]}');
                                    // if(itemsList[index].contains('sanf')){
                                    //   // var i=itemsList.indexOf(itemsList[index]);
                                    //   itemsList.removeRange(index, sanfMap[itemsList[index]]!);
                                    //   // itemsList.removeWhere((element) => element.contains(
                                    //   //     '${itemsList[index]
                                    //   //     }'));
                                    //   setState(() {
                                    //
                                    //   });
                                    // }
                                      itemsList.removeAt(index);
                                      sanfList1.removeAt(index);
                                      setState(() {

                                      });


                                  },
                                      icon: Icon(Icons.delete)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container(
                        key:ValueKey('${itemsList[index]}'),
                        margin: EdgeInsets.all(5),
                        width: width*80/100,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width:width*60/100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  initialValue:itemsList[index].contains('sanf') ?
                                  itemsList[index].substring(5):
                                  itemsList[index],
                                  decoration: InputDecoration(

                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    filled: true,
                                    alignLabelWithHint: false,
                                    label: Text((itemsList[index].startsWith('sanf'))?'كود الصنف':'سيريال ',
                                      style: TextStyle(fontWeight: FontWeight.bold ,
                                          color:itemsList[index].startsWith('sanf') ? Colors.black:
                                      Colors.black), textAlign: TextAlign.right,),
                                    fillColor: itemsList[index].startsWith('sanf') ?Colors.green :
                                    Colors.black.withOpacity(0.1),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  focusNode: focusList[index],
                                  onChanged: (value){
                                    if(value!.isNotEmpty && value.length>0){
                                      var x=sanfList1[index].substring(0 , sanfList1[index].indexOf(',')+1);
                                      sanfList1[index]= '$x $value';
                                      if(itemsList[index].contains("sanf")){
                                        itemsList[index]="sanf ${value}";
                                      }
                                      if( !itemsList[index].contains("sanf")){
                                        itemsList[index]=value;
                                      }
                                    }

                                    if(value.trim().characters.length==13)
                                    {
                                      focusNode: focus;
                                      // TextInputAction.next ;
                                      FocusScope.of(context).requestFocus(focusList[index+1]);
                                    }
                                  },
                                  onSaved: (v){
                                    if(v!.isNotEmpty && v.length>0){
                                      var x=sanfList1[index].substring(0 , sanfList1[index].indexOf(',')+1);
                                      sanfList1[index]= '$x $v';
                                      if(itemsList[index].contains("sanf")){
                                        itemsList[index]="sanf ${v}";
                                      }if(!itemsList[index].contains("sanf")){
                                        itemsList[index]=v;
                                      }
                                      serialMap['${index}']=v!;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: width*20/100,
                                child: IconButton(onPressed: (){
                                  print('itemsList[index] ${itemsList[index]}');

                                  if(itemsList[index].contains('sanf')==true){

                                    itemsList.removeWhere((element) => element.contains(
                                        '${itemsList[index]
                                        }'));
                                    setState(() {

                                    });
                                  }
                                  if(itemsList[index].contains('sanf')==false){
                                    print('index$index');
                                    itemsList.removeAt(index);
                                    sanfList1.removeAt(index);
                                     setState(() {

                                     });
                                  }


                                },
                                    icon: Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    ),)

                ],),
            ),
          ),
        ),
      ),
    );
  }
}
