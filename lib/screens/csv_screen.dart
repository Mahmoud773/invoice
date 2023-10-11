
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';


class CsvFile extends StatefulWidget {
  const CsvFile({Key? key}) : super(key: key);

  @override
  State<CsvFile> createState() => _CsvFileState();
}

class _CsvFileState extends State<CsvFile>  {

  void createCsv() async{
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-${DateTime.now()}.csv";
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

