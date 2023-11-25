import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<void> scanBarCodeNormal() async{
 String barcodeScanRes ;
 try{
   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
       'الغاء',
       true,
       ScanMode.BARCODE);
   print(barcodeScanRes);
 }on PlatformException  {
   barcodeScanRes='فشل المسح';
 }

}