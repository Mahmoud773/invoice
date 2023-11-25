import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data/Bill_Model.dart';
import '../dummy_data/file_storage.dart';
import 'grid_page.dart';
class Tasfeer extends StatefulWidget {
SharedPreferences? sharedPreferences;
Tasfeer({required this.sharedPreferences});

  @override
  State<Tasfeer> createState() => _TasfeerState();
}

class _TasfeerState extends State<Tasfeer> {
  List<BillTextModel>  myBills= [];
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

      var newContent='';


      FileStorage.writeCounter(
          '', "Fatora.txt");
    }


  }
  @override
  void initState() {
    read();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_outlined)
        ,
        onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
            return GridPage(sharedPreferences: widget.sharedPreferences, );
          }) );
        },),
        backgroundColor: Colors.green,
        title: Text('تصفير الفواتير'  , style: TextStyle(color: Colors.white , fontSize: 30),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                padding: EdgeInsets.all(5),

                decoration:  BoxDecoration(
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
                child: Text('لديك الان ${myBills.length} فاتورة ', style: TextStyle(
                  color: Colors.white , fontSize: 30,fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height: 10,),

              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(5),
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
                  child: InkWell(
                    onTap: (){
                      showDialog(context: context, builder:
                          (context){
                        return AlertDialog(
                          actions: [
                            TextButton(onPressed:(){
                               for(var i=0 ; i<myBills.length;i++)
                                myBills.forEach((element) {
                                  FileStorage.deleteFile('${element.path}');
                                });
                              myBills.clear();
                                // _createTextFile2();
                              save();
                              read();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                backgroundColor: Colors.blue,
                                duration: Duration(milliseconds: 2000),
                                dismissDirection: DismissDirection.up,
                                content: Text('تم حذف الفواتير'
                                  , style: TextStyle(color: Colors.white),) ,
                              ));

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
                            child: Text('هل تريد حذف جميع الفواتير', style:
                            TextStyle(color: Colors.white , fontSize: 30 ,
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.green,
                        );
                      });

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.delete ,color: Colors.white,) , ),
                        Text('حذف الفواتير ؟',style: TextStyle(
                          color: Colors.white, fontSize: 20
                        ),)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
