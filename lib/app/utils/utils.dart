import 'package:flutter/material.dart';

class Utils {
 static void showSnackBar({message, context, color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}
