
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// To save the file in the device
class FileStorage {
  static late    String filePath ;
  static Future<String> getExternalDocumentPath() async {


    //check android device info
    AndroidDeviceInfo build= await DeviceInfoPlugin().androidInfo;
    // To check whether permission is given for this app or not.
    if(build.version.sdkInt >=30){
     var re = await Permission.manageExternalStorage.request();
    }

    var status = await Permission.storage.status;

    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }

    var status1 = await Permission.manageExternalStorage.status;
    if (!status1.isGranted) {
      // If not we will ask for permission first
      await Permission.manageExternalStorage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      Directory? result = await getExternalStorageDirectory();
      if(result != null){
        _directory = Directory(result.path);
      }
      if(result == null ){
         result =await await getApplicationSupportDirectory();
        _directory = Directory(result.path);
      }
      // _directory = Directory("/storage/emulated/0/Download");

    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(String bytes,String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    File file= File('$path/$name');
    filePath =file.path;
    print('file.path${file.path}');
    print("Save file");

    // Write the data in the file you have created
    return file.writeAsString(bytes);

  }

  static Future<File> writeString(List<int> bytes,String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    File file= File('$path/$name');

    print("Save file");

    // Write the data in the file you have created

    return file.writeAsBytes(bytes);

  }

  static Future<void> deleteFile(String path) async {
    // final path = await _localPath;
   File file= File('$path');
   print('deleted path $path');
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
      print('error in deleting file ${e.toString()}');
    }
  }


}
