import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sys.attendance/app/config/config.dart';

import 'app/ui/pages/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: AppConfig.supabaseUrl, anonKey: AppConfig.supabaseKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
