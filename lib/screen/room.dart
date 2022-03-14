// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:math';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iq/api.dart';
import 'package:iq/widget/check_room.dart';
import 'package:iq/widget/my_room.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  int _selectedTab = 1;
  final screen = [const MyRoom(), const CheckRoom()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CupertinoSegmentedControl(
                      children: const <int, Widget>{
                        0: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('ห้องของฉัน')),
                        1: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('ห้องที่เข้าร่วม')),
                      },
                      groupValue: _selectedTab,
                      onValueChanged: (int value) {
                        setState(() {
                          _selectedTab = value;
                          //print(_selectedTab);
                        });
                      }),
                ),
              ],
            ),
          ),
          preferredSize: const Size(double.infinity, 48),
        ),
      ),
      body: screen[_selectedTab],
    );
  }
}
