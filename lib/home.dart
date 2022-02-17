import 'package:flutter/material.dart';
import 'package:iq/screen/about.dart';
import 'package:iq/screen/room.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('ชื่อผู้ใช้'),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
