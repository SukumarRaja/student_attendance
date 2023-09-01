// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/database.dart';
import '../utility/utility.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;
  final DatabaseService service = DatabaseService();

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

      if (response != null) {
        await service.insertUser(email: email, id: response.user!.id);
        Utility.showSnackBar(
            message: "Successfully registered !",
            context: context,
            color: Colors.green);
        await login(email: email, password: password, context: context);
        Navigator.pop(context);
        // setIsLoading = false;
      }
    } catch (e) {
      setIsLoading = false;
      Utility.showSnackBar(
          message: e.toString(), context: context, color: Colors.red);
    }
  }

  login({email, password, context}) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All fields are required");
      }
      final AuthResponse response = await client.auth
          .signInWithPassword(email: email, password: password);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utility.showSnackBar(
          message: e.toString(), context: context, color: Colors.red);
    }
  }

  logout() async {
    await client.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => client.auth.currentUser;
}
