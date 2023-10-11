import 'package:shared_preferences/shared_preferences.dart';

class MySP{
  late SharedPreferences mySp;


  static Future<SharedPreferences> sp() async {
    final  mySp= await SharedPreferences.getInstance();
    return mySp;
  }
// MySP(){
  //   init() async{
  //     mySp= await SharedPreferences.getInstance();
  //   }
  // }
}
