// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pap_report/utils/null_parse/null_safe_parse.dart';

OutletModel outletModelFromJson(String str) =>
    OutletModel.fromJson(json.decode(str));

String outletModelToJson(OutletModel data) => json.encode(data.toJson());

class OutletModel {
  String? code;
  Outlet? data;
  String? message;

  OutletModel({
    this.code,
    this.data,
    this.message,
  });

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
        code: nullSafeParse(json["code"]),
        data: Outlet.fromJson(json["data"]),
        message: nullSafeParse(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
      };

  @override
  String toString() =>
      'OutletModel(code: $code, data: $data, message: $message)';
}

class Outlet {
  List<Item> items;
  num? total;

  Outlet({
    this.items = const [],
    this.total,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
        items: List<Item>.from(
            (json["items"] ?? <Item>[]).map((x) => Item.fromJson(x))),
        total: nullSafeNumParse(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
      };

  @override
  String toString() => 'Outlet(items: $items, total: $total)';
}

class Item {
  String? type;
  num? value;

  Item({
    this.type,
    this.value,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      type: nullSafeParse(json["type"]),
      value: nullSafeNumParse(json["value"]));

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };

  @override
  String toString() => 'Item(type: $type, value: $value)';
}
