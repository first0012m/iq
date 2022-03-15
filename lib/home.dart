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

  Future Refresh() async {}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterSession().get('token'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Snapname = snapshot.data;
          print(Snapname);
          return FutureBuilder(
            future: home(Snapname),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return Scaffold(
                  body: RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    edgeOffset: 20,
                    onRefresh: Refresh,
                    child: Center(
                      child: Text('Home'),
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
                          child: Text(
                              '${snapshot.data['m_name']} ${snapshot.data['m_lastname']}'),
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
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error'),
                        TextButton(
                            onPressed: () {
                              FlutterSession().set('token', '');
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                  (route) => false);
                            },
                            child: const Text('ออกจากระบบ'))
                      ],
                    ),
                  ),
                );
                // return const Login();
              }
              return const Scaffold(
                body: Center(
                  child: Text("Loading"),
                ),
              );
            },
          );
        }
        return const Login();
      },
    );
  }
}
