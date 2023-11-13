import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:invoice/screens/TasdeerOrImport.dart';
import 'package:invoice/screens/Tasfeer.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/grid_Card.dart';

class GridPage extends StatefulWidget {
  SharedPreferences? sharedPreferences;

   GridPage({required this.sharedPreferences});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  Future<bool> _onWillPop() async {
      exit(0);
    return false; //<-- SEE HERE
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop ,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('الصفحة الرئيسية' , style: TextStyle(color: Colors.white
            , fontSize: 20 , fontWeight: FontWeight.bold),),
          )

        ],),
        body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: AssetImage('assets/images/store.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all( Radius.circular(50.0)),
              border: Border.all(
                color: Colors.green,
                width: 1.0,
              ),
            ),
          ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
                  itemCount: 4,
                  itemBuilder: (context , ind) {
                    return InkWell(onTap: (){
                      if(ind==0){
                        Navigator.push(context, MaterialPageRoute(builder:(context)
                        {return TasdeerOrImport(sharedPreferences: widget.sharedPreferences);}
                        ));

                      }
                      if(ind==1){
                        Navigator.push(context, MaterialPageRoute(builder:(context)
                        {return HomeScreen(sharedPreferences: widget.sharedPreferences, billLList: [],);}
                        ));

                      }
                      if(ind==2){
                        Navigator.push(context, MaterialPageRoute(builder:(context)
                        {return Tasfeer(sharedPreferences: widget.sharedPreferences, );}
                        ));

                      }
                      if(ind==3){
                        exit(0);

                      }


                    },
                        child: buildGridImage(ind));
                  }),
            ),
          ],),
        )


      ),
    );
      
  }
}
