import 'package:flutter/material.dart';
import 'package:tv_service/modules/auth/login.dart';
import 'package:tv_service/modules/customer/customer_home_screen.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';
import 'package:tv_service/services/db_services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}