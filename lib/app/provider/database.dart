import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/database_tables.dart';
import '../data/models/department.dart';
import '../data/models/user.dart';
import '../utility/utility.dart';

class DatabaseService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  UserModel? user;
  List<DepartmentModel> departments = [];
  int? employeeDepartment;

  insertUser({email, id}) async {
    await client.from(Tables.employee).insert({
      'id': id,
      'name': "",
      'email': email,
      'employee_id': Utility.generateRandomEmployeeId(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    final data = await client
        .from(Tables.employee)
        .select()
        .eq('id', client.auth.currentUser!.id)
        .single();
    user = UserModel.fromJson(data);
    employeeDepartment == null ? user?.department : null;
    return user!;
  }

  getAllDepartments() async {
    List res = await client.from(Tables.department).select();
    departments = res.map((e) => DepartmentModel.fromJson(e)).toList();
    notifyListeners();
  }

  updateProfile({name, context}) async {
    await client
        .from(Tables.employee)
        .update({'name': name, 'department': employeeDepartment}).eq(
            'id', client.auth.currentUser!.id);

    Utility.showSnackBar(
        message: "Profile Update Successfully",
        context: context,
        color: Colors.green);
    notifyListeners();
  }
}
