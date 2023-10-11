
import 'package:flutter/material.dart';
import 'package:invoice/dummy_data/Bill_Model.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import '../dummy_data/file_storage.dart';

class EditBillScreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  final BillTextModel billTextModel;
  final int currentIndex;
  int numberOfSerials;
  EditBillScreen({this.sharedPreferences ,required this.billTextModel ,required
  this.currentIndex ,  this.numberOfSerials=0});
  @override
  State<EditBillScreen> createState() => _EditBillScreenState();
}

class _EditBillScreenState extends State<EditBillScreen> {
  List<BillTextModel>  myBills= List.empty(growable:true );
  Map<String,String> _map={};
  Map<String,String> serialMap={};
  late SharedPreferences sp;
  // getSharedPrefrences() async {
  //   sp = await SharedPreferences.getInstance();
  //   readFromSp();
  //
  // }


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


  }
   @override
  void initState() {
    super.initState();
    read();
  }
  // void saveToSp(){
  //   List<String> myBillsStringList = myBills.map((bill) => jsonEncode(bill.toJson())).toList();
  //   sp.setStringList('myBills', myBillsStringList);
  // }
  //
  // void readFromSp(){
  //   List<String>? myBillsStringList = sp.getStringList('myBills');
  //   if(myBillsStringList!=null)
  //   {
  //     myBills = myBillsStringList.map((billString) => BillTextModel.fromJson(
  //         json.decode(billString))).toList();
  //   }
  //   setState(() {
  //
  //   });
  // }
  Future<void> _createTextFile({ required String name
    ,  BillTextModel? billTextModel}) async {
    _saveItem( );
    // Map<String,String> _map= {
    //   'id':billTextModel!.id,
    //    'billType':billTextModel.billType.toString() ,
    //     'serialList':billTextModel.serialMap.toString()
    // };
    FileStorage.writeCounter(
        _map.toString(), "$name.txt");
  }

  void _saveItem(  ){

    _map= {
      'id':widget.billTextModel.id,
      'enteredfileName':  widget.billTextModel.fileName,
      'billType':widget.billTextModel.billType.toString() ,
      'billNumber':widget.billTextModel.billNumber,
      'itemNumber':widget.billTextModel.itemNumber,
      'serialList':widget.billTextModel.serialMap.toString()
    };

    // saveToSp();


  }
  _createTextFile2 ({required Map<String,String> map ,required String name
    ,  BillTextModel? billTextModel})  {

    // _formKey.currentState!.save();
    List<String> list =[];
    map.forEach((key, value) { list.add(value);});
    list.map((e) => {"" :  ""});
    BillTextModel    billTextModel1=BillTextModel(id: DateTime.now().toString(), path: '',
        fileName: billTextModel!.fileName,
        billType: billTextModel!.billType,
        billNumber: billTextModel!.billNumber,
        itemNumber: billTextModel!.itemNumber,
        serialMap:list);

    _map= {
      'id':billTextModel!.id,
      'enteredfileName': billTextModel!.fileName ,
      'billType':billTextModel!.billType.toString() ,
      'billNumber':billTextModel!.billNumber,
      'itemNumber':billTextModel!.itemNumber,
      'serialList':billTextModel!.serialMap.toString()
    };

    FileStorage.writeCounter(
        _map.toString(), "$name.txt").then((file) {
      List<String> list =[];
      map.forEach((key, value) { list.add(value);});
      list.map((e) => {"" :  ""});
      myBills[widget.currentIndex].path=file.path;
      // billTextModel=BillTextModel(id: DateTime.now().toString(), path:value.path, fileName: enteredfileName,
      //     billType: _enteredBillType,
      //     billNumber: _enteredBillNumber,
      //     itemNumber: entereditemNumber, serialMap:list);
      // myBills.add(billTextModel!);
      save();

      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context) {
        return HomeScreen( sharedPreferences: widget.sharedPreferences,backAfterEdit: true,billLList: [],);
      }
      ));
    });

  }


  List<TextEditingController>  textList=[];
     var _billType=0;
  var _billNumber='';
  var _itemNumber='';

  var x = 0;
  var dropDownvalue=1;
  var noOfSerials=0;
  List<FocusNode> focusList=[];
  final focus = FocusNode();
  bool addListTextField=false;
   @override
  Widget build(BuildContext context) {
     noOfSerials=widget.billTextModel.serialMap.length;
     print('noOfSerials $noOfSerials');
     for(var i=0 ; i <widget.billTextModel.serialMap.length ;i++){
       focusList.insert(i, FocusNode());

     }
     // var  lenght= 3+(widget.billTextModel.serialMap.length);
      // var x = myBills.indexOf(widget.billTextModel);
  x =   myBills.indexWhere((element) => widget.billTextModel.path ==element.path);
  BillTextModel billTextModel = myBills[widget.currentIndex];
  print('${widget.billTextModel.path}');
  print('xx$x');
    print('xx$x');
    print('mybillslength ${myBills.length}');
    print('${widget.billTextModel.path}');
    // var y = myBills.indexOf(widget.billTextModel);
    print('${myBills.indexOf(widget.billTextModel)}');
  // print('${myBills[y].path}');
   //   print('my bILLLSlist ${myBills.length}');
     // textList =List.generate(lenght, (index) => TextEditingController()) ;
    return  Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(onPressed: () {
    myBills[widget.currentIndex].id=DateTime.now().toString();

    myBills[widget.currentIndex].billNumber=widget.billTextModel.billNumber;
    myBills[widget.currentIndex].fileName=widget.billTextModel.fileName;
    myBills[widget.currentIndex].itemNumber=widget.billTextModel.itemNumber;
    myBills[widget.currentIndex].billType =widget.billTextModel.billType;
    myBills[widget.currentIndex].serialMap=widget.billTextModel.serialMap;
    // _saveItem();
    _createTextFile2( map: serialMap,name: widget.billTextModel.fileName ,
    billTextModel: widget.billTextModel);
    }, child: Text('save' , style:
          TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
          fontSize: 20),)
          )
        ],
      ),

      body: Form(
        child: Container(
          padding: EdgeInsets.only(left: 15 , right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10 , bottom: 10),
                  child: Row(
                    children: [
                      Text('Bill Type' , style:TextStyle(fontSize: 15 , color: Colors.black ,
                          fontWeight: FontWeight.bold) ,),
                      SizedBox(width: 30,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.blue, spreadRadius: 3),
                            ],
                          ),
                        child: DropdownButton<int>(

                          icon: Icon(Icons.arrow_drop_down_outlined),
                          value: dropDownvalue,
                          items:  [
                            DropdownMenuItem(value: 1,
                              child: Text(widget.billTextModel.billType==1?'prepaid':'postpaid' ,
                                style: TextStyle(color: Colors.black
                                    ,fontWeight: FontWeight.bold),) ,),
                            DropdownMenuItem(value: 3,
                              child: Text('prepaid' ,
                                style: TextStyle(color: Colors.black
                                    ,fontWeight: FontWeight.bold),),),
                          ],
                          onChanged: (value) {
                            dropDownvalue = value!;
                            widget.billTextModel.billType =value;
                            setState(() {

                            });
                          } ,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width:double.infinity ,
                  child: TextFormField(initialValue: widget.billTextModel.fileName,
                    decoration:
                    InputDecoration(label: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold),)  ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3 , color: Colors.blue,)
                      ),
                    ),
                    onChanged: (x){
                    print('${widget.billTextModel.path}');
                      FileStorage.deleteFile(widget.billTextModel.path).then((value) {
                        widget.billTextModel.fileName =x;
                        setState(() {
                        });
                        }
                      );

                    },
                  ),
                ),
                // TextFormField(initialValue: widget.billTextModel.billType.toString(),
                // onChanged: (value){
                //
                //   setState(() {
                //     widget.billTextModel.billType =int.parse(value);
                //   });
                //
                // },
                //
                // ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width:double.infinity ,
                  child: TextFormField(
                    decoration:
                    InputDecoration(label: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold),)  ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3 , color: Colors.blue,)
                      ),
                    ),
                    initialValue: widget.billTextModel.billNumber,
                    onChanged: (value){
                      setState(() {
                        widget.billTextModel.billNumber =value;
                      });

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width:double.infinity ,
                  child: TextFormField(
                    decoration:
                    InputDecoration(label: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold),)  ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3 , color: Colors.blue,)
                      ),
                    ),
                    initialValue: widget.billTextModel.itemNumber,
                    onChanged: (value){
                      setState(() {
                        widget.billTextModel.itemNumber =value;
                      });

                    },
                  ),
                ),
                // serials
                Row(
                  children: [
                    Container(

                        child: Text('number of device serials' ,style:
                        TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)),
                    SizedBox(width: 30,),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                        ],
                      ),
                      width: 40,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget.billTextModel.serialMap.length.toString(),
                        decoration: InputDecoration(
                        ),
                        onChanged: (value){
                          widget.numberOfSerials=int.parse(value);
                          print('widget.numberOfSerials ${widget.numberOfSerials}');
                          noOfSerials = int.parse(value);
                          addListTextField=true;
                          for(var i=0 ; i <widget.numberOfSerials ;i++){
                            focusList.insert(i, FocusNode());
                          }
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child:
                  ListView.builder( itemCount:widget.numberOfSerials ,
                      itemBuilder: (context , ind){
                        if(ind == widget.numberOfSerials-1){
                          return  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.blue, spreadRadius: 3),
                              ],
                            ),
                            margin: EdgeInsets.only(top :10 ,bottom: 10),
                            width:double.infinity ,
                            child: TextFormField(

                                  initialValue:addListTextField ? '0':widget.billTextModel.serialMap![ind] ,
                              textInputAction: TextInputAction.done,
                              focusNode: focusList[widget.numberOfSerials-1],
                              autofocus: true,
                              decoration: InputDecoration(label: Text('serial'),
                              ),
                              onSaved: (value){
                                    if(noOfSerials==0){

                                    }
                                setState(() {

                                  var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
                                            serialMap['serial $i']=value! ;
                                             widget.billTextModel.serialMap![i] =value;
                                });
                              },
                              onChanged: (v){
                                if(v.trim().characters.length==13)
                                  FocusScope.of(context).unfocus();
                              },
                            ),
                          );
                        }
                        return  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.blue, spreadRadius: 3),
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 10 , top:10),
                          width:double.infinity ,
                          child: Container(
                            child: TextFormField(
                              initialValue:widget.billTextModel.serialMap![ind] ,
                              focusNode: focusList[ind],
                              // autofocus: true,
                              decoration: InputDecoration(label: Text('serial'),
                              ),
                              onSaved: (value){
                                setState(() {
                                  var i = widget.billTextModel.serialMap.indexOf(serialMap[ind]!);
                                  serialMap['serial $i']=value! ;
                                  widget.billTextModel.serialMap![i] =value;
                                });
                              },
                              onChanged: (v){
                                if(v.trim().characters.length==13)
                                {
                                  focusNode: focus;
                                  // TextInputAction.next ;
                                  FocusScope.of(context).requestFocus(focusList[ind+1]);
                                }
                              },
                            ),
                          ),
                        );
                      }),
                ),
                // if(addListTextField==false)
                //   Expanded(
                //     child: ListView(
                //       children:widget.billTextModel.serialMap!.map((e) =>
                //           Container(
                //             margin: EdgeInsets.only(top:10 , bottom: 10),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(color: Colors.blue, spreadRadius: 3),
                //               ],
                //             ),
                //             child: TextFormField(initialValue:e ,
                //               onChanged: (value){
                //                 setState(() {
                //                   var i = widget.billTextModel.serialMap!.indexOf(e);
                //                   serialMap['serial $i']=value ;
                //                   widget.billTextModel.serialMap![i] =value;
                //                 });
                //
                //               },),
                //           )
                //       ).toList(),
                //     ),
                //   ),
              ]
          ),
        ),
      ),
    );
  }
}
