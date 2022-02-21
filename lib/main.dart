// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:iq/home.dart';
import 'package:iq/screen/login.dart';
import 'package:iq/screen/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = await FlutterSession().get('token');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token != '' ? const Home() : const Login(),
    ),
  );
}