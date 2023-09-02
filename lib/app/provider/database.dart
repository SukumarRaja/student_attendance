import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/database_tables.dart';
import '../data/models/user.dart';
import '../utility/utility.dart';

class DatabaseService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  UserModel? user;

  insertUser({email, id}) async {
  var res =   await client.from(Tables.employee).insert({
      'id': id,
      'name': "",
      'email': email,
      'employee_id': Utility.generateRandomEmployeeId(),
      'department': null,
    });
  print("insert res ${res}");
  }

  Future<UserModel> getUserData() async {
    final data = await client
        .from(Tables.employee)
        .select()
        .eq('id', client.auth.currentUser!.id)
        .single();
    user = UserModel.fromJson(data);
    return user!;
  }
}
