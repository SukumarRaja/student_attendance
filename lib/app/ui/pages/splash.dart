import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import 'auth/home/home.dart';
import 'auth/login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    // auth.logout();
    return auth.currentUser == null ? const Login() : const Home();
  }
}
