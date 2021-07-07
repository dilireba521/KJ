import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseToast {
  static show(String msg) {
    cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black87.withAlpha(80),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static cancel() {
    Fluttertoast.cancel();
  }
}
