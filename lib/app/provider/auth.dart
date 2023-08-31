import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sys.attendance/app/utils/utils.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  register({email, password, context}) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All fields are required");
      }
      final AuthResponse response =
          await client.auth.signUp(email: email, password: password);
      Utils.showSnackBar(
          message: "Success ! you can now login",
          context: context,
          color: Colors.green);
      Navigator.pop(context);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(
          message: e.toString(), context: context, color: Colors.red);
    }
  }
}
