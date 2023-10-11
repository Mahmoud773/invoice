// To parse this JSON data, do
//
//     final billTextModel = billTextModelFromJson(jsonString);

import 'dart:convert';

BillTextModel billTextModelFromJson(String str) => BillTextModel.fromJson(json.decode(str));

String billTextModelToJson(BillTextModel data) => json.encode(data.toJson());

class BillTextModel {
  String id;
  String path;
  String fileName;
  int billType;
  String billNumber;
  String itemNumber;
  List<String> serialMap;

  BillTextModel({
    required this.id,
    required this.path,
    required this.fileName,
    required this.billType,
    required this.billNumber,
    required this.itemNumber,
    required this.serialMap,
  });

  factory BillTextModel.fromJson(Map<String, dynamic> json) => BillTextModel(
    id: json["id"],
    path: json["path"],
    fileName: json["fileName"],
    billType: json["billType"],
    billNumber: json["billNumber"],
    itemNumber: json["itemNumber"],
    serialMap: List<String>.from(json["serialMap"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "fileName": fileName,
    "billType": billType,
    "billNumber": billNumber,
    "itemNumber": itemNumber,
    "serialMap": List<dynamic>.from(serialMap.map((x) => x)),
  };
}
