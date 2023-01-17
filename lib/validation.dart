import 'dart:convert';
import 'package:crypto/crypto.dart';

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

String? emptyValue(String? value) {
  if (value == '') {
    return "Value can't be empty";
  } else {
    return null;
  }
}

String? valueMustBe6(String? value) {
  if (value!.length < 6 ) {
    return "Value can't be less than 6";
  } else {
    return null;
  }
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
