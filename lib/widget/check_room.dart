import 'package:flutter/material.dart';

class CheckRoom extends StatefulWidget {
  const CheckRoom({Key? key}) : super(key: key);

  @override
  State<CheckRoom> createState() => _CheckRoomState();
}

class _CheckRoomState extends State<CheckRoom> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('CheckRoom'),
        ),
      ),
    );
  }
}
