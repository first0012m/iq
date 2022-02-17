// ignore_for_file: non_constant_identifier_names
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iq/widget/check_room.dart';
import 'package:iq/widget/my_room.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  var rng = Random();
  int _selectedTab = 1;
  final screen = [const MyRoom(), const CheckRoom()];
  final _formKey = GlobalKey<FormState>();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddRoom();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> AddRoom() async {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('เพิ่มห้อง');
                        }
                      },
                      child: const Text(
                        'เพิ่ม',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabled: false,
                                labelText: 'ID',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10))),
                            validator: (value) {
                              rng.nextInt(100000);
                             // print(rng.nextInt(100000));
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'รหัสวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String? value) =>
                              value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'ชื่อวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String? value) =>
                              value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'ชื่อผู้สอน',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String? value) =>
                              value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
