// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    if (attendanceModel?.checkIn == null) {
      await client.from(Tables.attendance).insert({
        'employee_id': client.auth.currentUser!.id,
        'date': todayDate,
        'check_in': DateFormat("HH:mm").format(DateTime.now()),
        'check_out': null
      });
      Utility.showSnackBar(
          message: "Successfully Check In !",
          context: context,
          color: Colors.green);
    } else if (attendanceModel!.checkOut == null) {
      await client
          .from(Tables.attendance)
          .update({'check_out': DateFormat("HH:mm").format(DateTime.now())})
          .eq('employee_id', client.auth.currentUser!.id)
          .eq('date', todayDate);
    } else {
      Utility.showSnackBar(
          message: "You have already checked out today !", context: context);
    }
    getTodayAttendance();
  }

  Future<List<AttendanceModel>> getAttendanceHistory() async {
    List res = await client
        .from(Tables.attendance)
        .select()
        .eq('employee_id', client.auth.currentUser!.id)
        .textSearch('date', "$attendanceHistoryMonth", config: 'english')
        .order('created_at', ascending: false);
    print("history ${res}");
    return res.map((e) => AttendanceModel.fromJson(e)).toList();
  }
}
