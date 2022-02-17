import 'package:flutter/material.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({Key? key}) : super(key: key);

  @override
  State<MyRoom> createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('MyRoom'),
        ),
      ),
    );
  }
}
