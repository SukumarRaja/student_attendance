import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/user.dart';
import '../../provider/attendance.dart';
import '../../provider/database.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final controller = ActionSliderController();

  @override
  void initState() {
    Provider.of<AttendanceService>(context, listen: false).getTodayAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendance = Provider.of<AttendanceService>(context);
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: const Text(
              "Welcome",
              style: TextStyle(color: Colors.black54, fontSize: 30),
            ),
          ),
          Consumer<DatabaseService>(builder: (context, service, child) {
            return FutureBuilder(
                future: service.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.name != "" ? user.name : "#${user.employeeId}",
                        style: const TextStyle(fontSize: 25),
                      ),
                    );
                  }
                  return const SizedBox(
                    width: 60,
                    child: LinearProgressIndicator(),
                  );
                });
          }),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 12, bottom: 32),
            child: const Text(
              "Today Status",
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 12, bottom: 32),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Check In",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        attendance.attendanceModel?.checkIn ?? "--/--",
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Check Out",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        attendance.attendanceModel?.checkOut ?? "--/--",
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat("dd MMMM yyyy").format(DateTime.now()),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat("hh:mm:ss a").format(DateTime.now()),
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Builder(
              builder: (context) {
                return ActionSlider.standard(
                  sliderBehavior: SliderBehavior.stretch,
                  rolling: true,
                  // width: 300.0,
                  backgroundColor: Colors.white,
                  toggleColor: Colors.redAccent,
                  iconAlignment: Alignment.centerRight,
                  loadingIcon: const Center(
                      child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  )),
                  successIcon: const SizedBox(
                      width: 55,
                      child: Center(
                          child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ))),
                  icon: const SizedBox(
                      width: 55,
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))),
                  action: (controller) async {
                    controller.loading();
                    await Future.delayed(const Duration(seconds: 3), () async {
                      await attendance.markAttendance(context);
                      controller.success();
                    });

                    await Future.delayed(const Duration(seconds: 1));
                    controller.reset();
                  },
                  child: Text(attendance.attendanceModel?.checkIn == null
                      ? "Slide to Check In"
                      : "Slide to Check Out"),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
