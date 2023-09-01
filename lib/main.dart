import 'package:flutter/material.dart';
import 'package:flutter_application_14/screen.dart/home.dart';
import 'package:flutter_application_14/screen.dart/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: 'Users CRUD',
     initialRoute: '/',
     routes: {
      '/':(context) => const Home(),
      '/login' :(context) => const Login(),
     },
    );
  }
}
