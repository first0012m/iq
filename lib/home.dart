// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:iq/screen/about.dart';
import 'package:iq/screen/login.dart';
import 'package:iq/screen/room.dart';
import 'package:iq/service/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  // final  String action = await prefs.getString('action');
  String Snapname;
  @override
  void initState() {
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token');
    });
    super.initState();
  }

  @override
  Future Refresh() async {}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _token,
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
                  appBar: AppBar(),
                  body: RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    edgeOffset: 20,
                    onRefresh: Refresh,
                    child: const Center(
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
                          onTap: () async {
                            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();sharedPreferences.setString('token', '');
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
                            onPressed: () async {
                              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();sharedPreferences.setString('token', '');
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
