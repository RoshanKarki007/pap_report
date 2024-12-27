String nullSafeParse(Object? object, [String? alternative]) {
  if (object == null) {
    return alternative ?? "";
  }
  return object.toString();
}

num nullSafeNumParse(Object? object, [num alternative = 0]) {
  return num.parse(((num.tryParse(object?.toString() ?? "")) ?? alternative)
      .toStringAsFixed(2));
}

String nullSafeRemoveDecimalPoints(Object? object, [String? alternative = ""]) {
  if (object == null || object.toString().isEmpty) {
    return "0";
  }
  try {
    double value = double.parse(object.toString());
    return value.toInt().toString();
  } catch (e) {
    return alternative ?? object.toString();
  }
}

bool nullSafeBoolParse(Object? object, [bool alternative = false]) {
  if (object == null) {
    return alternative;
  }
  final lowerCased = object.toString().toLowerCase();
  if (lowerCased == 'true') {
    return true;
  } else if (lowerCased == 'false') {
    return false;
  }
  return alternative;
}
