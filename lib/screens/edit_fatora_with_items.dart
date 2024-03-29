
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:invoice/dummy_data/Bill_Model.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../dummy_data/file_storage.dart';
import '../widget/custom_page_route.dart';

class EditFatoraWithItems extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  final BillTextModel billTextModel;
  final int currentIndex;
  int numberOfSerials;
  List<String> serialList;
  bool comeFromEditwithoutEdit;
  EditFatoraWithItems({this.sharedPreferences ,required this.billTextModel ,required
  this.currentIndex ,  this.numberOfSerials=0 , required this.serialList , this.comeFromEditwithoutEdit=false});

  @override
  State<EditFatoraWithItems> createState() => _EditFatoraWithItemsState();
}

class _EditFatoraWithItemsState extends State<EditFatoraWithItems> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyDialog = GlobalKey<FormState>();
  var noOfSerials1=0;

  List<FocusNode> focusListDialog=[];
  final focusDialog = FocusNode();
  List<String> itemsList=[];

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
    widget.sharedPreferences!.setStringList('editList', widget.billTextModel.serialMap);

  }



  _createTextFile2 ({required Map<String,String> map
    ,  BillTextModel? billTextModel})  {

    // _formKey.currentState!.save();
    List<String> list =[];
    map.forEach((key, value) { list.add(value);});
    list.map((e) => {"" :  ""});
    BillTextModel    billTextModel1=BillTextModel(
        billType: billTextModel!.billType,
        billNumber: billTextModel!.billNumber,
        serialMap:list, branchNumber: '');

    _map= {
      'Bill Type':billTextModel!.billType.toString() ,
      'Bill Number':billTextModel!.billNumber,
      'Serials':billTextModel!.serialMap.toString()
    };
    var concatenate = StringBuffer();

    billTextModel!.serialMap.forEach((item){
      concatenate.write('\n serial ${billTextModel!.serialMap.indexOf(item)+1} : $item \n');
    });
    final String content= 'Bill Type : ${billTextModel!.billType.toString()}  \n'
        'Bill Number: ${billTextModel!.billNumber} \n '
        'Serials : $concatenate '  ;
    //new
    var concatenateSerialList = StringBuffer();
    var  concatenateMybillsList= StringBuffer();

    var newContent='';

    billTextModel=BillTextModel(
        billType: billTextModel.billType,
        billNumber: billTextModel.billNumber
        , serialMap:billTextModel.serialMap,
        branchNumber: billTextModel.branchNumber);


    List<StringBuffer> bufferList=[];
    for(var i=0;i<billTextModel!.serialMap.length;i++){
      bufferList.insert(i, StringBuffer());

    }
    //new new
    print('billTextModelafter save ${billTextModel.serialMap}');
    billTextModel!.serialMap.forEach((element) {
      if(element.contains('sanf')==false){
        bufferList[billTextModel!.serialMap.indexOf(element)].
        write('${billTextModel!.branchNumber},'
            '${billTextModel!.billType.toString()},'
            '${billTextModel!.billNumber}, $element \n');
      }
      concatenateMybillsList.write('${bufferList[billTextModel!.serialMap.indexOf(element)]} ');

    });

    // concatenateMybillsList.write('${element!.branchNumber},${element.billType.toString()},'
    //     '${element!.billNumber}, ${bufferList[myBills.indexOf(element)]} \n');
    newContent=concatenateMybillsList.toString() ;
    save();

    FileStorage.writeCounter(
        newContent, "${billTextModel!.billNumber}.txt").then((file) {
      // List<String> list =[];
      // map.forEach((key, value) { list.add(value);});
      // list.map((e) => {"" :  ""});

      save();
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
      myNavigatorWithNoreturnToUp(context , HomeScreen( sharedPreferences: widget.sharedPreferences,
         backAfterEdit: true,billLList: [],));
      // Navigator.pushReplacement(context, MaterialPageRoute(builder:
      //     (context) {
      //   return HomeScreen( sharedPreferences: widget.sharedPreferences,
      //     backAfterEdit: true,billLList: [],);
      // }
      // ));
    });

  }

  var sanfXXX='';
  List<TextEditingController>  textList=[];
  var _billType=0;
  var _billNumber='';
  var _itemNumber='';
  List<String> scannerList=[];
  List<TextEditingController> scannerTextEditControllerList=[];
  TextEditingController sanfTextController=TextEditingController();
  final focusSerialNumber=FocusNode();
  var x = 0;
  var dropDownvalue=1;
  var noOfSerials=0;
  List<FocusNode> focusList=[];
  final focus = FocusNode();
  bool addListTextField=false;
  List<String>   sanfList22=List.empty(growable:true );
  List<String>   addedserials=List.empty(growable:true );
  var sanfName='';
  Future<bool> _onWillPop() async{
    _formKey.currentState!.deactivate();
    List<String>?  editList=  widget.sharedPreferences!.getStringList('editList');
    if(editList !=null && editList.isNotEmpty ){
      widget.billTextModel.serialMap=editList;
      widget.sharedPreferences!.setStringList('editList' , []);
    }
    Navigator.pop(context);
    return false;
  }
  bool backafteraddItem=false;
  @override
  Widget build(BuildContext context) {
    if(backafteraddItem==true){
      setState(() {

      });
    }
    print("${widget.billTextModel.serialMap.toString()}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    noOfSerials=widget.billTextModel.serialMap.length;
    for(var i=0 ; i <widget.billTextModel.serialMap.length ;i++){
      focusList.insert(i, FocusNode());

    }

    // p =   myBills.indexWhere((element) => widget.billTextModel.path ==element.path);
    BillTextModel billTextModel = myBills[widget.currentIndex];
       // sanfList1=billTextModel.serialMap ;
      // billTextModel.serialMap.forEach((element) {
      //   if(element.contains('sanf')){
      //     sanfList22.add('$element');
      //   }
      //   if(element.contains('sanf')==false){
      //     sanfList22.add('xx$element');
      //   }
      // }) ;

     print('widget.serialList ${widget.serialList}');

      widget.billTextModel.serialMap.forEach((element) {
        if(element.contains('sanf')){
          sanfList22.add('$element');
        }
        if(element.contains('sanf')==false){
          sanfList22.add('xx$element');
        }
      });
      print('widget.billTextModel.serialMap${widget.billTextModel.serialMap}');
    // sanfList22=widget.serialList;
    //    print('sanfList22 $sanfList22');
    // addedserials= widget.billTextModel.serialMap.toSet().toList();
    //    if(backafteraddItem){
    //      addedserials= widget.billTextModel.serialMap.toSet().toList();
    //      print('widget.billTextModel.serialMap ${widget.billTextModel.serialMap}');
    //      print('addedserials$addedserials');
    //      setState(() {
    //
    //      });
    //    }

    // print('${myBills[y].path}');
    //   print('my bILLLSlist ${myBills.length}');
    // textList =List.generate(lenght, (index) => TextEditingController()) ;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.green,
          title: Center(
            child: Text('تعديل فاتورة' , style: TextStyle(color: Colors.white ,
              fontWeight: FontWeight.bold , ),
            ),
          ),
          actions: [
            TextButton(onPressed: () {
            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              myBills[widget.currentIndex].billNumber=widget.billTextModel.billNumber;
              myBills[widget.currentIndex].branchNumber=widget.billTextModel.branchNumber;
              myBills[widget.currentIndex].billType =widget.billTextModel.billType;
              myBills[widget.currentIndex].serialMap=widget.billTextModel.serialMap;
              print('myBills[widget.currentIndex].serialMap ${myBills[widget.currentIndex].serialMap}');

              // myBills[widget.currentIndex].serialMap=sanfList1;
              save();
              _createTextFile2( map: serialMap,
                  billTextModel: widget.billTextModel);
            }
            }, child: Text('تعديل' , style:
            TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
                fontSize: 20),)
            )
          ],
          leading: IconButton(onPressed: () {
            List<String>?  editList=  widget.sharedPreferences!.getStringList('editList');
            if(editList !=null && editList.isNotEmpty ){
              widget.billTextModel.serialMap=editList;
              widget.sharedPreferences!.setStringList('editList' , []);
            }

            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                (context) {
              return HomeScreen( sharedPreferences: widget.sharedPreferences,
                billLList: [],);
            }
            ));
          },
              icon: Icon(Icons.arrow_back , color: Colors.white,)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Form(
            key:_formKey ,
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

                                icon: Icon(Icons.arrow_drop_down_outlined),
                                value: widget.billTextModel.billType,
                                items:  [
                                  DropdownMenuItem(

                                    value: 1,
                                    child: Text('نقدى',
                                      style: TextStyle(color: Colors.black
                                          ,fontWeight: FontWeight.bold),) ,),
                                  DropdownMenuItem(value: 3,
                                    child: Text('أجلة' ,
                                      style: TextStyle(color: Colors.black
                                          ,fontWeight: FontWeight.bold),),),
                                ],

                                onChanged: (value) {
                                  widget.billTextModel.billType =value!;
                                  dropDownvalue = value!;
                                  print('widget.billTextModel.billType ${widget.billTextModel.billType}');
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
                            onTapOutside: (event){
                              // FocusManager.instance.primaryFocus?.unfocus();
                              FocusScope.of(context).unfocus();
                            },
                            textInputAction: TextInputAction.next,
                            initialValue: widget.billTextModel.branchNumber,
                            keyboardType: TextInputType.number,
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
                              if(value!.isNotEmpty && value!.length>0){
                                widget.billTextModel.branchNumber=value!;
                                setState(() {
                                  // _serialList.add(_enteredBillNumber);
                                  // map['_enteredBillType']=_enteredBillType.toString();

                                });
                              }

                            },
                            // onChanged: (value) {
                            //   widget.billTextModel.branchNumber=value!;
                            //
                            //   setState(() {
                            //
                            //   });
                            // },
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),
                      Container(

                        width:width*80/100 ,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                              onTapOutside: (event){
                                // FocusManager.instance.primaryFocus?.unfocus();
                                FocusScope.of(context).unfocus();
                              },
                              textInputAction: TextInputAction.next,
                              initialValue: widget.billTextModel.billNumber,
                              keyboardType: TextInputType.number,
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
                              // onChanged: (value){
                              //   setState(() {
                              //     widget.billTextModel.billNumber =value;
                              //   });
                              //
                              // },
                              onSaved: (v){
                                if(v!.isNotEmpty && v.length>0){
                                  widget.billTextModel.billNumber=v;

                                }
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      //items adding
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
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    AlertDialog(

                                                      title: Container(
                                                        width: width*80/100,
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width:  width*45/100,
                                                                child: TextFormField(
                                                                  onFieldSubmitted: (v){
                                                                    focusSerialNumber.requestFocus();
                                                                  },
                                                                  controller: sanfTextController,
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
                                                                     //  widget.billTextModel.serialMap.add
                                                                     //    ('sanf $value');
                                                                     //  //    sanfList1=widget.billTextModel.serialMap;
                                                                     // sanfName=value;
                                                                      sanfName=value;
                                                                      if(noOfSerials1>0){
                                                                        widget.billTextModel.serialMap.add
                                                                          ('${noOfSerials1}/sanf, $value');
                                                                      }else {
                                                                        widget.billTextModel.serialMap.add('sanf, $value');
                                                                      }



                                                                      // itemsList.add('sanf $value');
                                                                      // sanfList22.add('sanf, $value');
                                                                      // widget.billTextModel.serialMap.toSet().toList();


                                                                    }


                                                                  },
                                                                  onChanged: (value){

                                                                  },
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () async {
                                                                    String barcodeScanRes;
                                                                    try{
                                                                      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                                          'الغاء',
                                                                          true,
                                                                          ScanMode.BARCODE);
                                                                      print('barcodeScanRes $barcodeScanRes');

                                                                    }on PlatformException  {
                                                                      barcodeScanRes='فشل المسح';
                                                                    }if(!mounted)return ;
                                                                    setState(() {
                                                                      // scannerList[index] ='$barcodeScanRes';
                                                                      sanfTextController.text='$barcodeScanRes';
                                                                      // scannerList.insert(index, '$barcodeScanRes');

                                                                    });

                                                                  },
                                                                  icon: Icon(Icons.scanner)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      content: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Center(
                                                              child: Container(
                                                                margin: EdgeInsets.only(bottom: 10),
                                                                width: width*60/100,
                                                                child: Directionality(
                                                                  textDirection: TextDirection.rtl,
                                                                  child: TextFormField(
                                                                    textInputAction: TextInputAction.next,
                                                                    focusNode: focusSerialNumber,
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
                                                                      for(var i=0 ; i <noOfSerials1 ;i++){
                                                                        focusListDialog.insert(i, FocusNode());
                                                                        scannerList.insert(i, '');
                                                                        scannerTextEditControllerList.insert(i, TextEditingController());
                                                                        scannerTextEditControllerList[i].text='';
                                                                      }
                                                                      setState(() {

                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if(noOfSerials1>0)
                                                              Column(children: List.generate(noOfSerials1,
                                                                      (index)
                                                                  {
                                                                if(index == noOfSerials1-1)
                                                                {
                                                                  return Container(
                                                                  margin: EdgeInsets.all(5),
                                                                  width: width*80/100,
                                                                  child: Directionality(
                                                                    textDirection: TextDirection.rtl,
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Container(
                                                                          width:width*45/100,
                                                                          child: TextFormField(
                                                                            controller: scannerTextEditControllerList[index],
                                                                            textInputAction: TextInputAction.next,
                                                                            // onFieldSubmitted: (v){
                                                                            //   focusListDialog[index+1].requestFocus();
                                                                            // },
                                                                            // autofocus: true,
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
                                                                              if(value!.isNotEmpty && value!.length>0)
                                                                                widget.billTextModel.serialMap.
                                                                                add('$sanfName, $value');
                                                                              // sanfList1=widget.billTextModel.serialMap;
                                                                              // itemsList=widget.billTextModel.serialMap;

                                                                              // sanfList22.add('$sanfName, $value');
                                                                              // widget.billTextModel.serialMap.toSet().toList();
                                                                              var distinctIds =sanfList22.toSet().toList();
                                                                              print('distinctIds $distinctIds');

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
                                                                        IconButton(
                                                                            onPressed: () async {
                                                                              String barcodeScanRes;
                                                                              try{
                                                                                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                                                    'الغاء',
                                                                                    true,
                                                                                    ScanMode.BARCODE);
                                                                                print(barcodeScanRes);

                                                                              }on PlatformException  {
                                                                                barcodeScanRes='فشل المسح';
                                                                              }if(!mounted)return ;

                                                                              setState(() {
                                                                                scannerList[index] ='$barcodeScanRes';
                                                                                scannerTextEditControllerList[index].text='$barcodeScanRes';
                                                                                // scannerList.insert(index, '$barcodeScanRes');
                                                                                print('barcodeScanRes $barcodeScanRes');
                                                                                print(scannerList[index]);
                                                                                print('scannerList.length ${scannerList.length}');
                                                                                print('${scannerList}');
                                                                              });

                                                                              // itemsList.add('$barcodeScanRes');
                                                                              // sanfList1.add('$sanfName, $barcodeScanRes');

                                                                            },
                                                                            icon: Icon(Icons.scanner))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ) ;}
                                                                return Container(
                                                                  margin: EdgeInsets.all(5),
                                                                  width: width*80/100,
                                                                  child: Directionality(
                                                                    textDirection: TextDirection.rtl,
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Container(
                                                                          width:width*45/100,
                                                                          child: TextFormField(
                                                                            controller: scannerTextEditControllerList[index],
                                                                            textInputAction: TextInputAction.next,
                                                                            focusNode: focusListDialog[index],
                                                                            // autofocus: true,
                                                                            onFieldSubmitted: (v){
                                                                              focusListDialog[index+1].requestFocus();
                                                                            },
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
                                                                              if(value!.isNotEmpty && value!.length>0)
                                                                                widget.billTextModel.serialMap.
                                                                                add('$sanfName, $value');
                                                                              // sanfList1=widget.billTextModel.serialMap;
                                                                              // itemsList=widget.billTextModel.serialMap;
                                                                              // sanfList22.add('$sanfName, $value');
                                                                              // widget.billTextModel.serialMap.toSet().toList();
                                                                              var distinctIds =sanfList22.toSet().toList();
                                                                              print('sanfList22length${sanfList22.length}');
                                                                              print('distinctIds $distinctIds');

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
                                                                        IconButton(
                                                                            onPressed: () async {
                                                                              String barcodeScanRes;
                                                                              try{
                                                                                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                                                    'الغاء',
                                                                                    true,
                                                                                    ScanMode.BARCODE);
                                                                                print('barcodeScanRes $barcodeScanRes');

                                                                              }on PlatformException  {
                                                                                barcodeScanRes='فشل المسح';
                                                                              }if(!mounted)return ;
                                                                              setState(() {
                                                                                scannerList[index] ='$barcodeScanRes';
                                                                                scannerTextEditControllerList[index].text='$barcodeScanRes';
                                                                                // scannerList.insert(index, '$barcodeScanRes');
                                                                                print('barcodeScanRes $barcodeScanRes');
                                                                                print(scannerList[index]);
                                                                                print('scannerList.length ${scannerList.length}');
                                                                                print('${scannerList}');
                                                                              });

                                                                            },
                                                                            icon: Icon(Icons.scanner))
                                                                      ],
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

                                                            print('widget.billTextModel.serialMap${widget.billTextModel.serialMap}');
                                                            _formKeyDialog.currentState!.save();
                                                            scannerList=[];
                                                            scannerTextEditControllerList=[];
                                                            noOfSerials1=0;
                                                            sanfTextController.text='';
                                                            Navigator.of(context).pop();
                                                            backafteraddItem=true;
                                                          }

                                                        }, child: Text('حفظ')),
                                                        SizedBox(width:40 ,),
                                                        TextButton(
                                                            onPressed:() {
                                                              Navigator.of(context).pop();

                                                            }, child:
                                                        Text('الغاء' ,
                                                          style: TextStyle(fontSize: 20),)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
                      Column(children: List.generate(widget.billTextModel.serialMap.length, (index) {
                        for(var i=0 ; i <widget.billTextModel.serialMap.length ;i++){
                          focusList.insert(i, FocusNode());
                        }
                        if(index == widget.billTextModel.serialMap.length-1){
                          if(widget.billTextModel.serialMap[index].contains("sanf"))
                          {
                            return Container(
                              key: ObjectKey(widget.billTextModel.serialMap[index]),
                              margin: EdgeInsets.all(5),
                              width: width*80/100,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width*50/100,
                                      child: TextFormField(
                                        cursorColor: Colors.white,
                                        onTapOutside: (event){
                                          // FocusManager.instance.primaryFocus?.unfocus();
                                          FocusScope.of(context).unfocus();
                                        },
                                        textInputAction: TextInputAction.next,
                                        focusNode: focusList[index],
                                        onFieldSubmitted: (v){
                                          focusList[index+1].requestFocus();
                                        },
                                        initialValue:widget.billTextModel.serialMap[index].contains('sanf') ?
                                        widget.billTextModel.serialMap[index].substring(7).trim():
                                        widget.billTextModel.serialMap[index].substring(widget.billTextModel.serialMap[index].indexOf(',')+1).trim(),
                                        decoration: InputDecoration(

                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                            borderRadius: BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          alignLabelWithHint: false,
                                          label: Text((widget.billTextModel.serialMap[index].contains('/sanf'))?
                                          'كود الصنف':'سيريال ',
                                            style: TextStyle(fontWeight: FontWeight.bold ,
                                                color:widget.billTextModel.serialMap[index].contains('/sanf') ?
                                                Colors.black:
                                                Colors.black), textAlign: TextAlign.right,),
                                          fillColor: widget.billTextModel.serialMap[index].contains('/sanf') ?
                                          Colors.green :
                                          Colors.black.withOpacity(0.1),
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

                                        onChanged: (value){

                                          if(value!.isNotEmpty && value.length>0){
                                            // var x=sanfList22[index].substring(0 , sanfList22[index].indexOf(',')+1);
                                            // sanfList22[index]= '$x $value';
                                            var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);
                                            // widget.billTextModel.serialMap[index]= '$x $value';
                                            // print('onchangedsanfList22 $sanfList22');
                                            if(widget.billTextModel.serialMap[index].contains("sanf")){
                                              widget.billTextModel.serialMap[index]="$x ${value}";
                                            }
                                            if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                              widget.billTextModel.serialMap[index]='$x $value'
                                              ;
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
                                          if(v!.trim().isNotEmpty && v.trim().length>0){
                                            // var x=sanfList22[index].substring(0 ,
                                            //     sanfList22[index].indexOf(',')+1);
                                            // sanfList22[index]= '$x $v';
                                            var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);
                                            widget.billTextModel.serialMap[index]="${x.trim()} ${v.trim()}";
                                            // widget.billTextModel.serialMap[index]= '$x $v';
                                            // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]="$x ${v}";
                                            // }
                                            // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]='$x $v'
                                            //   ;
                                            // }
                                            serialMap['${index}']=v!;
                                          }
                                        },
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,

                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: width*10/100,
                                              child: IconButton(
                                                  onPressed: (){

                                                    // widget.billTextModel.serialMap.removeAt(index);
                                                    // if(itemsList[index].contains('sanf')==true){
                                                    //
                                                    //   itemsList.removeWhere((element) => element.contains(
                                                    //       '${itemsList[index]
                                                    //       }'));
                                                    //   setState(() {
                                                    //
                                                    //   });
                                                    // }


                                                    if(widget.billTextModel.serialMap[index].contains("sanf")){

                                                      showDialog(context: context, builder:
                                                          (context){
                                                        return AlertDialog(
                                                          actions: [
                                                            TextButton(onPressed:(){
                                                              var y =0;
                                                              var x =widget.billTextModel.serialMap[index].
                                                              substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
                                                              y=int.parse(x);
                                                              print(x);
                                                              print(y);

                                                              widget.billTextModel.serialMap.removeRange(index, index+y+1);
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
                                                            child: Text('هل تريد حذف الصنف بقائمة السيريال التابعة له', style:
                                                            TextStyle(color: Colors.white , fontSize: 30 ,
                                                                fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                          backgroundColor: Colors.green,
                                                        );
                                                      });

                                                    }
                                                    else {

                                                      var u=widget.billTextModel.serialMap[index].substring(0,
                                                        widget.billTextModel.serialMap[index].indexOf(',') ,
                                                      );
                                                      widget.billTextModel.serialMap.forEach((element) {
                                                        if(element.contains('sanf') && element.contains(u)){
                                                          print('element1 is sanf??? $element');
                                                          var y =0;
                                                          var x =element.
                                                          substring(0,  (element.indexOf('/'))) ;

                                                          y=int.parse(x);
                                                          print('xxx $x');
                                                          print('yyyy $y');
                                                          var pos = widget.billTextModel.serialMap.indexOf(element);
                                                          var newSanf= element.substring(1);
                                                          print('newSanf $newSanf');
                                                          var secondSanf= '${y-1}$newSanf';
                                                          print('secondSanf $secondSanf');
                                                          widget.billTextModel.serialMap[pos]=secondSanf;

                                                          print('element1 $element');
                                                        }

                                                      });
                                                      widget.billTextModel.serialMap.removeAt(index);
                                                      // sanfList22.removeAt(index);
                                                      setState(() {

                                                      });
                                                    }




                                                  },
                                                  icon: Icon(Icons.delete)),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  String x='';
                                                  String barcodeScanRes;

                                                  try{
                                                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                        'الغاء',
                                                        true,
                                                        ScanMode.BARCODE);
                                                    print(barcodeScanRes);

                                                  }on PlatformException  {
                                                    barcodeScanRes='فشل المسح';
                                                  }if(!mounted)return ;
                                                  if(widget.billTextModel.serialMap[index].contains("sanf")){
                                                    sanfXXX=widget.billTextModel.serialMap[index].substring(4 ,
                                                        widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                    print('xxx $x');


                                                    widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
                                                    widget.billTextModel.serialMap.forEach((element) {
                                                      if(element.contains(x)){
                                                        element.substring(0 ,
                                                            widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                        element='${barcodeScanRes}, $element' ;
                                                      }
                                                    });

                                                  }
                                                  if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                                    var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                        widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                    widget.billTextModel.serialMap[index]='$x $barcodeScanRes';
                                                  }
                                                  setState(() {

                                                  });
                                                },
                                                icon: Icon(Icons.scanner)),
                                          ],
                                        ),
                                        TextButton(onPressed: () {
                                          var x=widget.billTextModel.serialMap[index].substring(5) ;

                                          widget.billTextModel.serialMap.insert(index+1,'$x, ');
                                          setState(() {

                                          });
                                        },
                                            child: Text('اضافة سيريال'))
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ) ;
                          }else{
                            return Container(
                              key: ObjectKey(widget.billTextModel.serialMap[index]),
                              margin: EdgeInsets.all(5),
                              width: width*80/100,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width*50/100,
                                      child: TextFormField(
                                        onTapOutside: (event){
                                          // FocusManager.instance.primaryFocus?.unfocus();
                                          FocusScope.of(context).unfocus();
                                        },
                                        textInputAction: TextInputAction.next,
                                        initialValue:widget.billTextModel.serialMap[index].contains('sanf') ?
                                        widget.billTextModel.serialMap[index].substring(7).trim():
                                        widget.billTextModel.serialMap[index].substring(widget.billTextModel.serialMap[index].indexOf(',')+1).trim() ,
                                        decoration: InputDecoration(

                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                            borderRadius: BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          alignLabelWithHint: false,
                                          label: Text((widget.billTextModel.serialMap[index].startsWith('sanf'))?
                                          'كود الصنف':'سيريال  ',
                                            style: TextStyle(fontWeight: FontWeight.bold ,
                                                color:widget.billTextModel.serialMap[index].contains('/sanf') ? Colors.black:
                                                Colors.black), textAlign: TextAlign.right,),
                                          fillColor: widget.billTextModel.serialMap[index].contains('/sanf')?Colors.green :
                                          Colors.black.withOpacity(0.1),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                            borderRadius: BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        focusNode: focusList[widget.billTextModel.serialMap.length-1],
                                        // onChanged: (value){
                                        //   if(value!.isNotEmpty && value.length>0){
                                        //     // var x=sanfList22[index].substring(0 , sanfList22[index].indexOf(',')+1);
                                        //     // sanfList22[index]= '$x $value';
                                        //     var x=widget.billTextModel.serialMap[index].substring(0 ,
                                        //         widget.billTextModel.serialMap[index].indexOf(',')+1);
                                        //     // widget.billTextModel.serialMap[index]= '$x $value';
                                        //     // print('onchangedsanfList22 $sanfList22');
                                        //     if(widget.billTextModel.serialMap[index].contains("sanf")){
                                        //       widget.billTextModel.serialMap[index]="$x ${value}";
                                        //     }
                                        //     if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                        //       widget.billTextModel.serialMap[index]='$x $value'
                                        //       ;
                                        //     }
                                        //   }
                                        //
                                        //
                                        //   if(value.trim().characters.length==13)
                                        //     FocusScope.of(context).unfocus();
                                        //
                                        // },
                                        validator: (value){
                                          if(value!.isEmpty ||value.length<1)
                                          {return ' please Enter Valid value' ;}
                                          else return null ;

                                        },
                                        onSaved: (v){
                                          if(v!.trim().isNotEmpty && v.trim().length>0){
                                            // var x=sanfList22[index].substring(0 ,
                                            //     sanfList22[index].indexOf(',')+1);
                                            // sanfList22[index]= '$x $v';
                                            var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);

                                            widget.billTextModel.serialMap[index]="${x.trim()} ${v.trim()}";;
                                            // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]="$x ${v}";
                                            // }
                                            // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]='$x $v'
                                            //   ;
                                            // }
                                            // widget.billTextModel.serialMap[index]= '$x $v';
                                            // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]="$x ${v}";
                                            // }
                                            // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                            //   widget.billTextModel.serialMap[index]='$x $v'
                                            //   ;}
                                            serialMap['${index}']=v!;
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: width*10/100,
                                      child: IconButton(
                                          onPressed: (){

                                            // widget.billTextModel.serialMap.removeAt(index);
                                            // if(itemsList[index].contains('sanf')==true){
                                            //
                                            //   itemsList.removeWhere((element) => element.contains(
                                            //       '${itemsList[index]
                                            //       }'));
                                            //   setState(() {
                                            //
                                            //   });
                                            // }


                                            if(widget.billTextModel.serialMap[index].contains("sanf")){

                                              showDialog(context: context, builder:
                                                  (context){
                                                return AlertDialog(
                                                  actions: [
                                                    TextButton(onPressed:(){
                                                      var y =0;
                                                      var x =widget.billTextModel.serialMap[index].
                                                      substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
                                                      y=int.parse(x);
                                                      print(x);
                                                      print(y);

                                                      widget.billTextModel.serialMap.removeRange(index, index+y+1);
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
                                                    child: Text('هل تريد حذف الصنف بقائمة السيريال التابعة له', style:
                                                    TextStyle(color: Colors.white , fontSize: 30 ,
                                                        fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                );
                                              });

                                            }
                                            else {

                                              var u=widget.billTextModel.serialMap[index].substring(0,
                                                widget.billTextModel.serialMap[index].indexOf(',') ,
                                              );
                                              widget.billTextModel.serialMap.forEach((element) {
                                                if(element.contains('sanf') && element.contains(u)){
                                                  print('element1 is sanf??? $element');
                                                  var y =0;
                                                  var x =element.
                                                  substring(0,  (element.indexOf('/'))) ;

                                                  y=int.parse(x);
                                                  print('xxx $x');
                                                  print('yyyy $y');
                                                  var pos = widget.billTextModel.serialMap.indexOf(element);
                                                  var newSanf= element.substring(1);
                                                  print('newSanf $newSanf');
                                                  var secondSanf= '${y-1}$newSanf';
                                                  print('secondSanf $secondSanf');
                                                  widget.billTextModel.serialMap[pos]=secondSanf;

                                                  print('element1 $element');
                                                }

                                              });
                                              widget.billTextModel.serialMap.removeAt(index);
                                              // sanfList22.removeAt(index);
                                              setState(() {

                                              });
                                            }




                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          var x ='';
                                          String barcodeScanRes;
                                          try{
                                            barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                'الغاء',
                                                true,
                                                ScanMode.BARCODE);
                                            print(barcodeScanRes);

                                          }on PlatformException  {
                                            barcodeScanRes='فشل المسح';
                                          }if(!mounted)return ;
                                          // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                          //   widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
                                          // }if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                          //   widget.billTextModel.serialMap[index]=barcodeScanRes;
                                          // }
                                          if(widget.billTextModel.serialMap[index].contains("sanf")){
                                            var  x=widget.billTextModel.serialMap[index].substring(4 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);
                                            // widget.billTextModel.serialMap.forEach((element) {
                                            //   if(element.contains(x)){
                                            //     element='${barcodeScanRes}, $element' ;
                                            //   }
                                            // });
                                            print('xanf xxx $x');
                                            widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
                                            widget.billTextModel.serialMap.forEach((element) {
                                              if(element.contains(x)){
                                                element.substring(0 ,
                                                    widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                element='${barcodeScanRes}, $element' ;
                                              }
                                            });

                                          }
                                          if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                            var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);
                                            widget.billTextModel.serialMap[index]='$x $barcodeScanRes';
                                          }
                                          setState(() {

                                          });
                                        },
                                        icon: Icon(Icons.scanner)),
                                  ],
                                ),
                              ),
                            );
                          }

                        }
                        if(widget.billTextModel.serialMap[index].contains("sanf"))
                         {
                           return Stack(
                             alignment: AlignmentDirectional.bottomEnd,
                             children: [
                               Container(
                                 height: 100,

                                 key: ObjectKey(widget.billTextModel.serialMap[index]),
                                  margin: EdgeInsets.only(right :20,left: 10,top: 10,bottom: 10),
                                 width: width*75/100,
                                 decoration: BoxDecoration(
                                     color: Colors.green,
                                     border: Border.all(
                                       color: Colors.green,
                                     ),
                                     borderRadius: BorderRadius.all(Radius.circular(50))
                                 ),
                                 child: Directionality(
                                   textDirection: TextDirection.rtl,
                                   child: Container(
                                     width: width*70/100,
                                     // margin: EdgeInsets.only(bottom: 5),
                                     child: TextFormField(
                                       cursorColor: Colors.white,
                                       onTapOutside: (event){
                                         // FocusManager.instance.primaryFocus?.unfocus();
                                         FocusScope.of(context).unfocus();
                                       },
                                       textInputAction: TextInputAction.next,
                                       focusNode: focusList[index],
                                       onFieldSubmitted: (v){
                                         focusList[index+1].requestFocus();
                                       },
                                       initialValue:widget.billTextModel.serialMap[index].contains('sanf') ?
                                       widget.billTextModel.serialMap[index].substring(7).trim():
                                       widget.billTextModel.serialMap[index].substring(widget.billTextModel.serialMap[index].indexOf(',')+1).trim(),
                                       decoration: InputDecoration(

                                         focusedBorder: OutlineInputBorder(
                                           borderSide:
                                           BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                           borderRadius: BorderRadius.circular(50.0),
                                         ),
                                         filled: true,
                                         alignLabelWithHint: false,
                                         label: Text((widget.billTextModel.serialMap[index].contains('/sanf'))?
                                         'كود الصنف':'سيريال ',
                                           style: TextStyle(fontWeight: FontWeight.bold ,
                                               color:widget.billTextModel.serialMap[index].contains('/sanf') ?
                                               Colors.black:
                                               Colors.black), textAlign: TextAlign.right,),
                                         fillColor: widget.billTextModel.serialMap[index].contains('/sanf') ?
                                         Colors.green :
                                         Colors.black.withOpacity(0.1),
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

                                       onChanged: (value){

                                         if(value!.isNotEmpty && value.length>0){
                                           // var x=sanfList22[index].substring(0 , sanfList22[index].indexOf(',')+1);
                                           // sanfList22[index]= '$x $value';
                                           var x=widget.billTextModel.serialMap[index].substring(0 ,
                                               widget.billTextModel.serialMap[index].indexOf(',')+1);
                                           // widget.billTextModel.serialMap[index]= '$x $value';
                                           // print('onchangedsanfList22 $sanfList22');
                                           widget.billTextModel.serialMap[index]='$x $value';
                                           // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                           //   widget.billTextModel.serialMap[index]="$x ${value}";
                                           // }
                                           // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                           //   widget.billTextModel.serialMap[index]='$x $value'
                                           //   ;
                                           // }
                                         }

                                         if(value.trim().characters.length==13)
                                         {
                                         focusNode: focus;
                                         // TextInputAction.next ;
                                         FocusScope.of(context).requestFocus(focusList[index+1]);
                                         }
                                       },

                                       onSaved: (v){
                                         if(v!.trim().isNotEmpty && v.trim().length>0){
                                           // var y =0;
                                           // var p =widget.billTextModel.serialMap[index].
                                           // substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
                                           // print('pppp$p');
                                           // var t =widget.billTextModel.serialMap[index].substring
                                           //   (widget.billTextModel.serialMap[index].indexOf(',')+1
                                           //   );
                                           // print('ttt$t');
                                           // y=int.parse(p);
                                           // print(p);
                                           // print(y);
                                           // List<String> serials =[];
                                           // List<String> serials2 =[];
                                           //
                                           // serials = widget.billTextModel.serialMap.getRange(index+1, index+y+1).toList();
                                           // print('serials $serials');
                                           // serials.forEach((element) {
                                           //   var  v=element.substring(7).trim() ;
                                           //   print('vvvv$v');
                                           //   element='$v, ' ;
                                           //   print('element serial $element');
                                           //   serials2.add('$t $v');
                                           //   // var x=widget.billTextModel.serialMap[index].substring(7).trim() ;
                                           //
                                           // });
                                           // print('serials2 $serials2');
                                           // // widget.billTextModel.serialMap.replaceRange(start, end, replacements)
                                           // widget.billTextModel.serialMap.replaceRange(index, index+y, serials.toList());
                                           // Navigator.of(context).pop();
                                           // var x=sanfList22[index].substring(0 ,
                                           //     sanfList22[index].indexOf(',')+1);
                                           // sanfList22[index]= '$x $v';
                                           var ooo=widget.billTextModel.serialMap[index].substring(0 ,
                                               widget.billTextModel.serialMap[index].indexOf(',')+1);
                                           widget.billTextModel.serialMap[index]="${ooo.trim()} ${v.trim()}";
                                           // widget.billTextModel.serialMap[index]= '$x $v';
                                           // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                           //   widget.billTextModel.serialMap[index]="$x ${v}";
                                           // }
                                           // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                           //   widget.billTextModel.serialMap[index]='$x $v'
                                           //   ;
                                           // }
                                           serialMap['${index}']=v!;
                                         }
                                       },
                                     ),
                                   ),
                                 ),
                               ),
                               // SizedBox(height: 5,),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Center(
                                   child: Container(

                                     decoration: BoxDecoration(
                                         // color: Colors.white,
                                         border: Border.all(
                                           color: Colors.green,
                                         ),
                                         borderRadius: BorderRadius.all(Radius.circular(50))
                                     ),
                                     child: Row(

                                       mainAxisSize: MainAxisSize.max,
                                       mainAxisAlignment:MainAxisAlignment.spaceAround ,

                                       children: [
                                         IconButton(
                                             onPressed: () async {
                                               String x='';
                                               String barcodeScanRes;

                                               try{
                                                 barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                                     'الغاء',
                                                     true,
                                                     ScanMode.BARCODE);
                                                 print(barcodeScanRes);

                                               }on PlatformException  {
                                                 barcodeScanRes='فشل المسح';
                                               }if(!mounted)return ;
                                               if(widget.billTextModel.serialMap[index].contains("sanf")){
                                                 sanfXXX=widget.billTextModel.serialMap[index].substring(4 ,
                                                     widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                 print('xxx $x');


                                                 widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
                                                 widget.billTextModel.serialMap.forEach((element) {
                                                   if(element.contains(x)){
                                                     element.substring(0 ,
                                                         widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                     element='${barcodeScanRes}, $element' ;
                                                   }
                                                 });

                                               }
                                               if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                                 var x=widget.billTextModel.serialMap[index].substring(0 ,
                                                     widget.billTextModel.serialMap[index].indexOf(',')+1);
                                                 widget.billTextModel.serialMap[index]='$x $barcodeScanRes';
                                               }
                                               setState(() {

                                               });
                                             },
                                             icon: Icon(Icons.scanner ,color: Colors.white,)),
                                         Container(
                                           width: width*10/100,
                                           child: IconButton(
                                               onPressed: (){

                                                 // widget.billTextModel.serialMap.removeAt(index);
                                                 // if(itemsList[index].contains('sanf')==true){
                                                 //
                                                 //   itemsList.removeWhere((element) => element.contains(
                                                 //       '${itemsList[index]
                                                 //       }'));
                                                 //   setState(() {
                                                 //
                                                 //   });
                                                 // }


                                                 if(widget.billTextModel.serialMap[index].contains("sanf")){

                                                   showDialog(context: context, builder:
                                                       (context){
                                                     return AlertDialog(
                                                       actions: [
                                                         TextButton(onPressed:(){
                                                           var y =0;
                                                           var x =widget.billTextModel.serialMap[index].
                                                           substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
                                                           y=int.parse(x);
                                                           print(x);
                                                           print(y);

                                                           widget.billTextModel.serialMap.removeRange(index, index+y+1);
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
                                                         child: Text('هل تريد حذف الصنف بقائمة السيريال التابعة له', style:
                                                         TextStyle(color: Colors.white , fontSize: 30 ,
                                                             fontWeight: FontWeight.bold),
                                                         ),
                                                       ),
                                                       backgroundColor: Colors.green,
                                                     );
                                                   });

                                                 }
                                                 else {

                                                   var u=widget.billTextModel.serialMap[index].substring(0,
                                                     widget.billTextModel.serialMap[index].indexOf(',') ,
                                                   );
                                                   widget.billTextModel.serialMap.forEach((element) {
                                                     if(element.contains('sanf') && element.contains(u)){
                                                       print('element1 is sanf??? $element');
                                                       var y =0;
                                                       var x =element.
                                                       substring(0,  (element.indexOf('/'))) ;

                                                       y=int.parse(x);
                                                       print('xxx $x');
                                                       print('yyyy $y');
                                                       var pos = widget.billTextModel.serialMap.indexOf(element);
                                                       var newSanf= element.substring(1);
                                                       print('newSanf $newSanf');
                                                       var secondSanf= '${y-1}$newSanf';
                                                       print('secondSanf $secondSanf');
                                                       widget.billTextModel.serialMap[pos]=secondSanf;

                                                       print('element1 $element');
                                                     }

                                                   });
                                                   widget.billTextModel.serialMap.removeAt(index);
                                                   // sanfList22.removeAt(index);
                                                   setState(() {

                                                   });
                                                 }




                                               },
                                               icon: Icon(Icons.delete , color: Colors.white,)),
                                         ),

                                         TextButton(onPressed: () {
                                           var x=widget.billTextModel.serialMap[index].substring(7).trim() ;

                                           widget.billTextModel.serialMap.insert(index+1,'$x, ');
                                           setState(() {

                                           });
                                         },
                                             child: Text('اضافة سيريال' ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),))
                                       ],
                                     ),
                                     // color: Colors.green[50],
                                     width: width*60/100,
                                     margin: EdgeInsets.all(5),
                                   ),
                                 ),
                               ),
                             ]
                           ) ;
                         }
                        else return Container(
                          key: ObjectKey(widget.billTextModel.serialMap[index]),
                          margin: EdgeInsets.all(5),
                          width: width*80/100,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width: width*50/100,
                                  child: TextFormField(
                                    onTapOutside: (event){
                                      // FocusManager.instance.primaryFocus?.unfocus();
                                      FocusScope.of(context).unfocus();
                                    },
                                    textInputAction: TextInputAction.next,
                                    focusNode: focusList[index],
                                    onFieldSubmitted: (v){
                                      focusList[index+1].requestFocus();
                                    },
                                    initialValue:widget.billTextModel.serialMap[index].contains('sanf') ?
                                    widget.billTextModel.serialMap[index].substring(7).trim():
                                    widget.billTextModel.serialMap[index].substring(widget.billTextModel.serialMap[index].indexOf(',')+1).trim(),
                                    decoration: InputDecoration(

                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      filled: true,
                                      alignLabelWithHint: false,
                                      label: Text((widget.billTextModel.serialMap[index].contains('/sanf'))?
                                      'كود الصنف':'سيريال ',
                                        style: TextStyle(fontWeight: FontWeight.bold ,
                                            color:widget.billTextModel.serialMap[index].contains('/sanf') ?
                                            Colors.black:
                                            Colors.black), textAlign: TextAlign.right,),
                                      fillColor: widget.billTextModel.serialMap[index].contains('/sanf') ?
                                      Colors.green :
                                      Colors.black.withOpacity(0.1),
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
                                    onChanged: (v){
                                      print('change $v');
                                      print(widget.billTextModel.serialMap);
                                    },


                                    // onChanged: (value){
                                    //
                                    //   if(value!.isNotEmpty && value.length>0){
                                    //     // var x=sanfList22[index].substring(0 , sanfList22[index].indexOf(',')+1);
                                    //     // sanfList22[index]= '$x $value';
                                    //     var x=widget.billTextModel.serialMap[index].substring(0 ,
                                    //         widget.billTextModel.serialMap[index].indexOf(',')+1);
                                    //     // widget.billTextModel.serialMap[index]= '$x $value';
                                    //     // print('onchangedsanfList22 $sanfList22');
                                    //     if(widget.billTextModel.serialMap[index].contains("sanf")){
                                    //       widget.billTextModel.serialMap[index]="$x ${value}";
                                    //     }
                                    //     if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                    //       widget.billTextModel.serialMap[index]='$x $value'
                                    //       ;
                                    //     }
                                    //   }
                                    //
                                    //   if(value.trim().characters.length==13)
                                    //   {
                                    //   focusNode: focus;
                                    //   // TextInputAction.next ;
                                    //   FocusScope.of(context).requestFocus(focusList[index+1]);
                                    //   }
                                    // },

                                      onSaved: (v){
                                        if(v!.trim().isNotEmpty && v.trim().length>0){
                                          // var x=sanfList22[index].substring(0 ,
                                          //     sanfList22[index].indexOf(',')+1);
                                          // sanfList22[index]= '$x $v';
                                          var x=widget.billTextModel.serialMap[index].substring(0 ,
                                              widget.billTextModel.serialMap[index].indexOf(',')+1);
                                          widget.billTextModel.serialMap[index]="${x.trim()} ${v.trim()}";

                                          // widget.billTextModel.serialMap[index]= '$x $v';
                                          // if(widget.billTextModel.serialMap[index].contains("sanf")){
                                          //   widget.billTextModel.serialMap[index]="$x ${v}";
                                          // }
                                          // if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                          //   widget.billTextModel.serialMap[index]='$x $v'
                                          //   ;
                                          // }
                                          serialMap['${index}']=v!;
                                        }
                                      },
                                  ),
                                ),
                                Container(
                                  width: width*10/100,
                                  child: IconButton(
                                      onPressed: (){

                                        // widget.billTextModel.serialMap.removeAt(index);
                                        // if(itemsList[index].contains('sanf')==true){
                                        //
                                        //   itemsList.removeWhere((element) => element.contains(
                                        //       '${itemsList[index]
                                        //       }'));
                                        //   setState(() {
                                        //
                                        //   });
                                        // }


                                        if(widget.billTextModel.serialMap[index].contains("sanf")){

                                          showDialog(context: context, builder:
                                              (context){
                                            return AlertDialog(
                                              actions: [
                                                TextButton(onPressed:(){
                                                  var y =0;
                                                  var x =widget.billTextModel.serialMap[index].
                                                  substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
                                                  y=int.parse(x);
                                                  print(x);
                                                  print(y);

                                                  widget.billTextModel.serialMap.removeRange(index, index+y+1);
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
                                                child: Text('هل تريد حذف الصنف بقائمة السيريال التابعة له', style:
                                                TextStyle(color: Colors.white , fontSize: 30 ,
                                                    fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              backgroundColor: Colors.green,
                                            );
                                          });

                                        }
                                        else {

                                          var u=widget.billTextModel.serialMap[index].substring(0,
                                            widget.billTextModel.serialMap[index].indexOf(',') ,
                                          );
                                          widget.billTextModel.serialMap.forEach((element) {
                                            if(element.contains('sanf') && element.contains(u)){
                                              print('element1 is sanf??? $element');
                                              var y =0;
                                              var x =element.
                                              substring(0,  (element.indexOf('/'))) ;

                                              y=int.parse(x);
                                              print('xxx $x');
                                              print('yyyy $y');
                                              var pos = widget.billTextModel.serialMap.indexOf(element);
                                              var newSanf= element.substring(1);
                                              print('newSanf $newSanf');
                                              var secondSanf= '${y-1}$newSanf';
                                              print('secondSanf $secondSanf');
                                              widget.billTextModel.serialMap[pos]=secondSanf;

                                              print('element1 $element');
                                            }

                                          });
                                          widget.billTextModel.serialMap.removeAt(index);
                                          // sanfList22.removeAt(index);
                                          setState(() {

                                          });
                                        }




                                      },
                                      icon: Icon(Icons.delete)),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      String x='';
                                      String barcodeScanRes;

                                      try{
                                        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
                                            'الغاء',
                                            true,
                                            ScanMode.BARCODE);
                                        print(barcodeScanRes);

                                      }on PlatformException  {
                                        barcodeScanRes='فشل المسح';
                                      }if(!mounted)return ;
                                      if(widget.billTextModel.serialMap[index].contains("sanf")){
                                        sanfXXX=widget.billTextModel.serialMap[index].substring(4 ,
                                            widget.billTextModel.serialMap[index].indexOf(',')+1);
                                        print('xxx $x');


                                        widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
                                        widget.billTextModel.serialMap.forEach((element) {
                                          if(element.contains(x)){
                                            element.substring(0 ,
                                                widget.billTextModel.serialMap[index].indexOf(',')+1);
                                            element='${barcodeScanRes}, $element' ;
                                          }
                                        });

                                      }
                                      if(!widget.billTextModel.serialMap[index].contains("sanf")){
                                        var x=widget.billTextModel.serialMap[index].substring(0 ,
                                            widget.billTextModel.serialMap[index].indexOf(',')+1);
                                        widget.billTextModel.serialMap[index]='$x $barcodeScanRes';
                                      }
                                      setState(() {

                                      });
                                    },
                                    icon: Icon(Icons.scanner)),
                              ],
                            ),
                          ),
                        );
                      }
                      ),),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
