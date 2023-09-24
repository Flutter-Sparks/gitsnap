import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message.toUpperCase(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 13.0);
  }

  static String numberFormat(int num) {
    NumberFormat formatter = NumberFormat.compact(
      locale: 'en_us',
      
    );
    return formatter.format(num);
  }
}
