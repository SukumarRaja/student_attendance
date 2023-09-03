// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sys.attendance/app/provider/location.dart';
import '../config/database_tables.dart';
import '../data/models/attendance.dart';
import '../utility/utility.dart';

class AttendanceService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  AttendanceModel? attendanceModel;

  var todayDate = DateFormat("dd MMMM yyyy").format(DateTime.now());

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _attendanceHistoryMonth =
      DateFormat("MMMM yyyy").format(DateTime.now());

  String get attendanceHistoryMonth => _attendanceHistoryMonth;

  set attendanceHistoryMonth(String value) {
    _attendanceHistoryMonth = value;
    notifyListeners();
  }

  getTodayAttendance() async {
    List res = await client
        .from(Tables.attendance)
        .select()
        .eq('employee_id', client.auth.currentUser!.id)
        .eq('date', todayDate);
    if (res.isNotEmpty) {
      attendanceModel = AttendanceModel.fromJson(res.first);
    }
    notifyListeners();
  }

  markAttendance(BuildContext context) async {
    Map? getLocation =
        await LocationService().initializeAndGetLocation(context);

    if (getLocation != null) {
      if (attendanceModel?.checkIn == null) {
        await client.from(Tables.attendance).insert({
          'employee_id': client.auth.currentUser!.id,
          'date': todayDate,
          'check_in': DateFormat("HH:mm").format(DateTime.now()),
          'check_out': "",
          'check_in_location': getLocation
        });
        Utility.showSnackBar(
            message: "Successfully Check In !",
            context: context,
            color: Colors.green);
      } else if (attendanceModel!.checkOut == "") {
        await client
            .from(Tables.attendance)
            .update({
              'check_out': DateFormat("HH:mm").format(DateTime.now()),
              'check_out_location': getLocation
            })
            .eq('employee_id', client.auth.currentUser!.id)
            .eq('date', todayDate);
      } else {
        Utility.showSnackBar(
            message: "You have already checked out today !", context: context);
      }
      getTodayAttendance();
    } else {
      Utility.showSnackBar(
          message: "Not able to get your location", context: context);
      getTodayAttendance();
    }
  }

  Future<List<AttendanceModel>> getAttendanceHistory() async {
    List res = await client
        .from(Tables.attendance)
        .select()
        .eq('employee_id', client.auth.currentUser!.id)
        .textSearch('date', "'$attendanceHistoryMonth'", config: 'english')
        .order('created_at', ascending: false);
    return res.map((e) => AttendanceModel.fromJson(e)).toList();
  }
}
