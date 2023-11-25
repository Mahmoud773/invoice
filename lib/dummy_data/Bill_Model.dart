import 'dart:convert';

BillTextModel billTextModelFromJson(String str) => BillTextModel.fromJson(json.decode(str));

String billTextModelToJson(BillTextModel data) => json.encode(data.toJson());

class BillTextModel {
  String branchNumber;
  int billType;
  String billNumber;
  List<String> serialMap;
  String? path;

  BillTextModel({
    required this.branchNumber,
    required this.billType,
    required this.billNumber,
    required this.serialMap,
    this.path,
  });

  factory BillTextModel.fromJson(Map<String, dynamic> json) => BillTextModel(
    branchNumber: json["branchNumber"],
    billType: json["billType"],
    billNumber: json["billNumber"],
    serialMap: List<String>.from(json["serialMap"].map((x) => x)),
    path: json["path"]
  );

  Map<String, dynamic> toJson() => {
    "branchNumber": branchNumber,
    "billType": billType,
    "billNumber": billNumber,
    "serialMap": List<dynamic>.from(serialMap.map((x) => x)),
    "path":path
  };
}
