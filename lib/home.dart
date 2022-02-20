// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:iq/screen/about.dart';
import 'package:iq/screen/login.dart';
import 'package:iq/screen/room.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterSession().get('token'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text('Home'),
                ),
              ),
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
