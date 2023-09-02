import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import 'package:sys.attendance/app/data/models/attendance.dart';
import '../../provider/attendance.dart';

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
            margin: EdgeInsets.only(left: 20, top: 60, bottom: 10),
            child: Text(
              "My Attendance",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                attendance.attendanceHistoryMonth,
                style: TextStyle(fontSize: 25),
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
                  child: Text("Pick a month"))
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: attendance.getAttendanceHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            AttendanceModel model = snapshot.data![index];

                            return Container(
                              margin: EdgeInsets.only(
                                  top: 12, bottom: 10, left: 20, right: 20),
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        // DateFormat("EE \n dd")
                                        //     .format(model.createdAt),
                                        "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Check in",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Divider(),
                                        ),
                                        Text(
                                          model.checkIn.toString() ?? "--/--",
                                          style: TextStyle(fontSize: 25),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text(
                        "No Data Avilable",
                        style: TextStyle(fontSize: 25),
                      );
                    }
                  }
                  return LinearProgressIndicator(
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
