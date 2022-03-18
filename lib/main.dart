// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe
library flutter_session;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iq/home.dart';
import 'package:iq/screen/login.dart';
import 'package:iq/screen/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: prefs.getString('token') != '' ? const Home() : const Login(),
    ),
  );
}