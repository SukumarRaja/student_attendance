import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/config/config.dart';
import 'app/provider/attendance.dart';
import 'app/provider/database.dart';
import 'app/provider/auth.dart';
import 'app/ui/pages/splash.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => AttendanceService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
    );
  }
}
