import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice/dummy_data/Bill_Model.dart';
import 'package:invoice/dummy_data/file_storage.dart';
import 'package:invoice/screens/edit_bill_screen.dart';

import '../dummy_data/dummy_excell_screen.dart';
import 'add_fatora.dart';
import 'package:path/path.dart' as pathP;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


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


  // late SharedPreferences sp;
  // late SharedPreferences _sharedPreferences;
  // getSharedPrefrences() async {
  //   // sp = await SharedPreferences.getInstance();
  //   _sharedPreferences= await SharedPreferences.getInstance();
  //   readFromSp();
  // }

  // void saveToSp(){
  //   List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
  //   // sp.setStringList('myBills', myBillsStringList);
  //   _sharedPreferences.setStringList('myBills', myBillsStringList);
  // }

  // void readFromSp() {
  //
  //   // List<String>? myBillsStringList = sp.getStringList('myBills');
  //   //
  //   // if(myBillsStringList!=null)
  //   // {
  //   //   myBills =myBillsStringList.map((billString) => BillTextModel.fromJson(
  //   //       json.decode(billString))).toList();
  //   // }
  //   List<String>? myBillsStringList2=_sharedPreferences.getStringList('myBills');
  //   if(myBillsStringList2!=null)
  //   {
  //     myBills =myBillsStringList2.map((billString) => BillTextModel.fromJson(
  //         json.decode(billString))).toList();
  //   }
  //   setState(() {
  //
  //   });
  // }

  //my SHared check
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

  // void getListSerial() async{
  //
  //   List<String> dataserialList =  sp.getStringList(widget.billNameSP)!;
  //   if(dataserialList !=null){
  //     serialList=dataserialList;
  //     serialList.map((e) => BillModel(billName: serialList[0],
  //          billNumber: serialList[1], serialList: serialList.sublist(2) as List<String>)) as BillModel;
  //
  //   }
  //   setState(() {
  //
  //   });
  // }



  final List<String> billItemsList=[];
  void _addFatora(){
    Navigator.push(context, MaterialPageRoute(builder:(context)
    {return DummyExcellScreen(sharedPreferences: widget.sharedPreferences,);}
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

    return  Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading:false
      ),
      body:myBills.isEmpty ? Center(child: Text(' no bills yet' , style: TextStyle(color: Colors.blue
      , fontSize: 40 , fontWeight: FontWeight.bold)),)
          :
          ListView.builder(itemCount:myBills.length ,
              itemBuilder: (context , index){
            return Padding(padding: EdgeInsets.all(5) ,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.blue, spreadRadius: 3),
                  ],
                ),
                height: 120,
                child: Card(
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                // color: Colors.purpleAccent.withOpacity(0.7),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      children:[

                        CircleAvatar(backgroundColor:myBills[index].billType==1? Colors.yellow:Colors.blue
                            ,
                            child: Text(myBills[index].billType==1?'prepaid' : 'postpaid',
                              style: TextStyle(
                               color: myBills[index].billType==1?   Colors.black: Colors.white,
                                fontSize: 15
                            ),),
                            radius: 33),
                        SizedBox(width: 15,),
                        Flexible(
                          child: Text('${myBills[index].fileName}' ,
                            style: TextStyle(

                            color: Colors.blue,
                              fontSize: 20
                          ),),
                        ),
                        SizedBox(width: 80,),
                        Row(
                          children: [
                            IconButton(onPressed: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return EditBillScreen( sharedPreferences: widget.sharedPreferences,
                                  billTextModel: myBills[index] , currentIndex: index,
                                numberOfSerials:myBills[index].serialMap.length ,);
                              }));

                            }, icon: Icon(Icons.edit , color: Colors.blue,)),
                            IconButton(onPressed: () {

                              FileStorage.deleteFile('${myBills[index].path}');
                              myBills.removeAt(index);
                              // print('${myBills[index].fileName}');
                              save();
                              read();
                              setState(() {

                              });

                            }, icon: Icon(Icons.delete,color: Colors.blue,)),
                          ],
                        )
                      ]
                  ),
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
      floatingActionButton:FloatingActionButton(onPressed: _addFatora ,
      child: Icon(Icons.add)) ,
    );
  }
}
