// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:iq/api.dart';
import 'package:iq/screen/about.dart';
import 'package:iq/screen/login.dart';
import 'package:iq/screen/room.dart';
import 'package:http/http.dart' as http;
import 'package:iq/service/data_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String Snapname;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterSession().get('token'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Snapname = snapshot.data;
          //print(Snapname);
          home(Snapname);
          return Scaffold(
            body: FutureBuilder(
              future: home(Snapname),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text('Home'),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                return const Center(
                  child: Text('Loading'),
                );
              },
            ),
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(snapshot.data),
                  ),
                  ListTile(
                    title: const Text('ห้อง'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Room(),
                      ));
                    },
                  ),
                  ListTile(
                    title: const Text('รายงาน'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('เกี่ยวกับ'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const About(),
                      ));
                    },
                  ),
                  ListTile(
                    title: const Text('ออกจากระบบ'),
                    onTap: () {
                      FlutterSession().set('token', '');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Login();
      },
    );
  }
}
