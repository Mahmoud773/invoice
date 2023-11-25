import 'package:flutter/material.dart';
import 'package:invoice/screens/grid_page.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:invoice/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences? _sharedPreferences;
Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();

  _sharedPreferences=await SharedPreferences.getInstance();
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// comment after update pod files
//lkkkkkkkkkkkkkkkkkk


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZIBEN',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home:
       GridPage(sharedPreferences: _sharedPreferences)
       // HomeScreen( sharedPreferences: _sharedPreferences,billLList: []),
    );
  }
}

