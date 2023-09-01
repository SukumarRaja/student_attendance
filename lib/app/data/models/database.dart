import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/database_tables.dart';
import '../../utility/utility.dart';

class DatabaseService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  insertUser({email, id}) async {
    await client.from(Tables.employee).insert({
      'id': id,
      'name': "",
      'email': email,
      'employee_id': Utility.generateRandomEmployeeId(),
      'department': null,
    });
  }
}
