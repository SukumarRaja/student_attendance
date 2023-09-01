import 'dart:math';
import 'package:flutter/material.dart';

class Utility {
  static void showSnackBar({message, context, color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  static String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "faangFAANG0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }
}
