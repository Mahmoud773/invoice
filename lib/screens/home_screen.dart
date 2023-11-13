import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice/dummy_data/Bill_Model.dart';
import 'package:invoice/dummy_data/file_storage.dart';
import 'package:invoice/screens/edit_bill_screen.dart';
import 'package:invoice/screens/grid_page.dart';

import '../dummy_data/dummy_excell_screen.dart';
import 'add_fatora.dart';
import 'package:path/path.dart' as pathP;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_fatora1.dart';
import 'add_fatora_with_items.dart';
import 'edit_fatora1.dart';
import 'edit_fatora_with_items.dart';


class HomeScreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
   String billNameSP;
   String firstSerial;
   String secondSerial;
   bool backAfterAddBill ;
   bool backAfterEdit;
   List<BillTextModel>   billLList;
  HomeScreen({this.sharedPreferences,
     this.billNameSP='' ,  this.firstSerial ='', this.secondSerial='',this.backAfterAddBill=false ,
    this.backAfterEdit=false , required this.billLList ,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var x='';
  var y ='';
  var c='';
  var filePath='';
  var pppp='';
   List<String> serialList=[];

  List<BillTextModel>  myBills= [];
  List<BillTextModel>  bills= [];


  void save(){
    List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
    widget.sharedPreferences!.setStringList('myBills', myBillsStringList);
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

  _createTextFile2 ({ Map<String,String>? map , String? name
    ,  BillTextModel? billTextModel1})  {
    {

      var concatenateSerialList = StringBuffer();
      var  concatenateMybillsList= StringBuffer();


      var newContent='';
      // myBills.forEach((element) {
      //   element.serialMap.forEach((item){
      //     concatenateSerialList.write('\n${ item.contains('Item') ?'Item name ${item.substring(6)}' :
      //     'serial ${element!.serialMap.indexOf(item)+1} : $item \n'}  ');
      //     // 'serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n');
      //   });
      //   concatenateMybillsList.write('Bill Type : ${element.billType.toString()}  \n'
      //       'Bill Number: ${element!.billNumber} \n '
      //       'Branch Number : ${element!.branchNumber} \n'
      //       'Serials : ${element.serialMap.toString()} \n' )  ;
      //   newContent=concatenateMybillsList.toString() ;
      // });
      // myBills.forEach((element) {
      //   element.serialMap.forEach((item){
      //     concatenateSerialList.write('\n${ item.contains('Item') ?'Item name ${item.substring(6)}' :
      //     'serial ${element!.serialMap.indexOf(item)+1} : $item \n'}  ');
      //     // 'serial ${billTextModel2!.serialMap.indexOf(item)+1} : $item \n');
      //   });
      //   var list = ['one', 'two', 'three'];
      //   var concatenate = StringBuffer();
      //   list.forEach((item){
      //     concatenate.write(item);
      //   });
      //
      //   List<StringBuffer> bufferList=[];
      //
      //   for(var i=0 ;i<myBills.length;i++){
      //     bufferList.insert(i, StringBuffer());
      //     element.serialMap.forEach((item) {
      //       bufferList[i].write(item.contains('sanf') ?'${item.substring(5)},' : '$item,');
      //       // bufferList[i].write('$item,');
      //     });
      //   }
      //
      //   // concatenateMybillsList.write('Bill Type : ${element.billType.toString()}  \n'
      //   //     'Bill Number: ${element!.billNumber} \n '
      //   //     'Branch Number : ${element!.branchNumber} \n'
      //   //     'Serials : ${element.serialMap.toString()} \n' )  ;
      //   concatenateMybillsList.write('${element!.branchNumber},${element.billType.toString()},'
      //       '${element!.billNumber}, ${bufferList[myBills.indexOf(element)]} \n');
      //   newContent=concatenateMybillsList.toString() ;
      // });
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
      FileStorage.writeCounter(
          newContent, "Fatora.txt").then((value) {
        List<String> list =[];
        map!.forEach((key, value) { list.add(value);});
        list.map((e) => {"" :  ""});

        widget.sharedPreferences!.setString('lastPath', value.path);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   behavior: SnackBarBehavior.floating,
        //   shape: RoundedRectangleBorder(
        //     side: BorderSide(color: Colors.blue, width: 2),
        //     borderRadius: BorderRadius.circular(24),
        //   ),
        //   backgroundColor: Colors.blue,
        //   duration: Duration(milliseconds: 2000),
        //   dismissDirection: DismissDirection.up,
        //   content: Text('تم حذف الفاتورة'
        //     , style: TextStyle(color: Colors.white),) ,
        // ));

      });
    }


  }


  final List<String> billItemsList=[];
  void _addFatora(){
    Navigator.push(context, MaterialPageRoute(builder:(context)
    {return AddFatoraWithItems(sharedPreferences: widget.sharedPreferences,);}
    ));
  }
  @override
  void initState() {
    // getSharedPrefrences();
    super.initState();
    // getSharedPrefrences();
    read();
    print('init state');
  }

  Future<bool> _onWillPop() async{
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return GridPage(sharedPreferences: widget.sharedPreferences);
   }));
   return false;
  }
  @override
  Widget build(BuildContext context) {
    // if(widget.sharedPreferences!.getString('lastPath') !=null){
    //   print('widget.sharedPreferences!.getString ${widget.sharedPreferences!.getString('lastPath')}');
    // }
        if(widget.backAfterAddBill){
            read();
          setState(() {

          });
          widget.backAfterAddBill= false;
        }
    if(widget.backAfterEdit){
           read();
           setState(() {

      });
      widget.backAfterEdit= false;
    }
    // getSharedPrefrences();
    // if(custombillsList!=null &&custombillsList.isNotEmpty){
    //   print("custombillsList ${custombillsList.length}");
    // }
    // if(_billModelList.isNotEmpty){
    //   print("_billModelList ${_billModelList.length}");
    //   print("_billModelList ${_billModelList[5].serialList}");
    // }

    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
           leading:IconButton(onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
               return GridPage(sharedPreferences: widget.sharedPreferences,);
             }));
           }, icon:
           Icon(Icons.arrow_back , color: Colors.white,)
           ),
          title: Text('الفواتير' , style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body:myBills.isEmpty ? Center(child: Text(' لا توجد فواتير' , style: TextStyle(color: Colors.green
        , fontSize: 40 , fontWeight: FontWeight.bold)),)
            :
            ListView.builder(itemCount:myBills.length ,
                itemBuilder: (context , index){
              return Padding(padding: EdgeInsets.all(5) ,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: Colors.green,
                    // boxShadow: [
                    //   BoxShadow(color: Colors.green, spreadRadius: 3),
                    // ],
                    gradient: LinearGradient(colors: [

                      Color(0xFF8ab526),
                      Color(0xFF26b56b),

                    ])
                  ),
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                        children:[

                          CircleAvatar(backgroundColor:myBills[index].billType==1? Colors.white:Colors.white
                              ,
                              child: Text(myBills[index].billType==1?'نقدى' : 'أجلة',
                                style: TextStyle(
                                 color: myBills[index].billType==1?   Colors.black: Colors.black,
                                  fontSize: 15
                              ),),
                              radius: 33),
                          SizedBox(width: 5,),
                          Container(
                            width: 100,
                            child: Text('فاتورة رقم ${myBills[index].billNumber}' ,
                              style: TextStyle(

                              color: Colors.white,
                                fontSize: 20
                            ),),
                          ),
                          SizedBox(width: 50,),
                          Row(
                            children: [
                              IconButton(onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return EditFatoraWithItems( sharedPreferences: widget.sharedPreferences,
                                    billTextModel: myBills[index] , currentIndex: index,
                                  numberOfSerials:myBills[index].serialMap.length ,serialList:
                                    myBills[index].serialMap,
                                  );
                                }));

                              }, icon: Icon(Icons.edit , color: Colors.white,)),
                              IconButton(onPressed: () {
                                 showDialog(context: context, builder:
                                 (context){
                                   return AlertDialog(
                                     actions: [
                                       TextButton(onPressed:(){
                                         myBills.removeAt(index);
                                         save();
                                         // FileStorage.deleteFile('${myBills[index].path}');
                                         _createTextFile2();

                                         // print('${myBills[index].fileName}');
                                         Navigator.of(context).pop();
                                         setState(() {

                                         });
                                       } , child: Text('نعم', style:
                                       TextStyle(color: Colors.white , fontSize: 30 ,
                                           fontWeight: FontWeight.bold))),
                                       TextButton(onPressed: (){
                                         Navigator.of(context).pop();
                                       }, child: Text('لا' ,
                                           style:
                                           TextStyle(color: Colors.white , fontSize: 30 ,
                                           fontWeight: FontWeight.bold)))
                                     ],
                                     content: Directionality(
                                       textDirection: TextDirection.rtl,
                                       child: Text('هل تريد حذف الفاتورة', style:
                                         TextStyle(color: Colors.white , fontSize: 30 ,
                                             fontWeight: FontWeight.bold),
                                       ),
                                     ),
                                     backgroundColor: Colors.green,
                                   );
                                 });


                              }, icon: Icon(Icons.delete,color: Colors.white,)),
                            ],
                          )
                        ]
                    ),
                  ),
                ),);
            }),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(width: 50 ,height: 50, child:
        //     Text((custombillsList!=null) ? '${custombillsList[0].billName}'
        //       :'no bills'
        //     ,
        //       style: TextStyle(color: Colors.red),),),
        //     Container(width: 50 ,height: 50, child:
        //     Text((custombillsList!=null) ? '${custombillsList[0].billNumber}'
        //         :'no bills'
        //       ,style: TextStyle(color: Colors.red),),),
        //     Container(width: 50 ,height: 50, child:
        //     Text((custombillsList!=null) ? '${custombillsList[0].serialList.length.toString()}'
        //         :'no bills',
        //       style: TextStyle(color: Colors.red , fontSize: 50),),),
        //   ],
        // ),
        floatingActionButton:FloatingActionButton(backgroundColor: Colors.green,
          onPressed: _addFatora ,
        child: Icon(Icons.add) , ) ,
      ),
    );
  }
}
