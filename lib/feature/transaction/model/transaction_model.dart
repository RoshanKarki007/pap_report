import 'dart:convert';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/utils/null_parse/null_safe_parse.dart';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));
String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  String? code;
  Transaction? data;
  String? message;

  TransactionModel({
    this.code,
    this.data,
    this.message,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        code: nullSafeParse(json["code"]),
        data: Transaction.fromJson(json["data"]),
        message: nullSafeParse(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
      };

  @override
  String toString() =>
      'TransactionModel(code: $code, data: $data, message: $message)';
}

class Transaction {
  List<Item> items;
  num? total;

  Transaction({
    this.items = const [],
    this.total,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        items:
            List<Item>.from((json["items"] ?? []).map((x) => Item.fromJson(x))),
        total: nullSafeNumParse(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<Item>.from(items.map((x) => x.toJson())),
        "total": total,
      };

  @override
  String toString() => 'Transaction(items: $items, total: $total)';
}
