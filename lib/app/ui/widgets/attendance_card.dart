import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard(
      {super.key,
      required this.date,
      required this.checkIn,
      required this.checkOut});

  final DateTime date;
  final String checkIn;
  final String checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 10, left: 20, right: 20),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                DateFormat("EE \n dd").format(date),
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Check in",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(
                  width: 80,
                  child: Divider(),
                ),
                Text(
                  checkIn.toString() ?? "--/--",
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Check Out",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(
                  width: 80,
                  child: Divider(),
                ),
                Text(
                  checkOut.toString() ?? "--/--",
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
