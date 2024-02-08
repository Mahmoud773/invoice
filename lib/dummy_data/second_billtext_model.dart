// To parse this JSON data, do
//
//     final secondBillTextModel = secondBillTextModelFromJson(jsonString);

import 'dart:convert';

SecondBillTextModel secondBillTextModelFromJson(String str) => SecondBillTextModel.fromJson(json.decode(str));

String secondBillTextModelToJson(SecondBillTextModel data) => json.encode(data.toJson());

class SecondBillTextModel {
  String branchNumber;
  int billType;
  String billNumber;
  String path;
  SerialMap serialMap;

  SecondBillTextModel({
    required this.branchNumber,
    required this.billType,
    required this.billNumber,
    required this.path,
    required this.serialMap,
  });

  factory SecondBillTextModel.fromJson(Map<String, dynamic> json) => SecondBillTextModel(
    branchNumber: json["branchNumber"],
    billType: json["billType"],
    billNumber: json["billNumber"],
    path: json["path"],
    serialMap: SerialMap.fromJson(json["serialMap"]),
  );

  Map<String, dynamic> toJson() => {
    "branchNumber": branchNumber,
    "billType": billType,
    "billNumber": billNumber,
    "path": path,
    "serialMap": serialMap.toJson(),
  };
}

class SerialMap {
  SerialMap();

  factory SerialMap.fromJson(Map<String, dynamic> json) => SerialMap(
  );

  Map<String, dynamic> toJson() => {
  };
}
