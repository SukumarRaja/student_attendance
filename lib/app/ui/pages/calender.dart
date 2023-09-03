import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import 'package:sys.attendance/app/data/models/attendance.dart';
import '../../provider/attendance.dart';
import '../widgets/attendance_card.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    final attendance = Provider.of<AttendanceService>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20, top: 60, bottom: 10),
            child: const Text(
              "My Attendance",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                attendance.attendanceHistoryMonth,
                style: const TextStyle(fontSize: 25),
              ),
              OutlinedButton(
                  onPressed: () async {
                    final selectedDate =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                            context: context, disableFuture: true);
                    String pickedMonth =
                        DateFormat("MMMM yyyy").format(selectedDate);
                    attendance.attendanceHistoryMonth = pickedMonth;
                  },
                  child: const Text("Pick a month"))
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: attendance.getAttendanceHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            AttendanceModel model = snapshot.data![index];
                            return AttendanceCard(
                              date: model.createdAt,
                              checkIn: model.checkIn,
                              checkOut: model.checkOut,
                            );
                          });
                    } else {
                      return const Text(
                        "No Data Available",
                        style: TextStyle(fontSize: 25),
                      );
                    }
                  }
                  return const LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                  );
                }),
          )
        ],
      ),
    );
  }
}
