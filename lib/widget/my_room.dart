import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iq/api.dart';
import 'package:iq/service/data_dalete_myroom.dart';
import 'package:iq/service/data_myroom.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({Key key}) : super(key: key);

  @override
  State<MyRoom> createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  final TextEditingController _num = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var rng = Random();
  String baseUrl = Api.Room;

  String msg = "";
  int random = 0;
   List list;
   String m_random;
   String m_num;
   String m_name;

  Randoms() async {
    random = rng.nextInt(100000);
    print(random);
  }

  Room() async {
    final prefs = await SharedPreferences.getInstance();
    var room = await http.post(Uri.parse(baseUrl), body: {
      "m_random": random.toString(),
      "m_num": _num.text,
      "m_name": _name.text,
      "m_ajname": await prefs.getString('token')
    });
    var data = jsonDecode(room.body);
    _num.clear();
    _name.clear();
    print(data);

    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: My_room(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                list = snapshot.data;
                m_random = list[index]['m_random'];
                m_num = list[index]['m_num'];
                m_name = list[index]['m_name'];
                return ListTile(
                  title: Text(m_num + ' ' + m_name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Delete_My_room(list[index]['m_random'],
                                  list[index]['m_num'], list[index]['m_name']);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Sheet(list[index]['m_random'], list[index]['m_num'],
                                list[index]['m_name']);
                          },
                          icon: const Icon(Icons.more_vert)),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Randoms();
                AddRoom();
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: const Center(
              child: Text('ไม่มีข้อมูล'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Randoms();
                AddRoom();
              },
              child: const Icon(Icons.add),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text("Loading"),
          ),
        );
      },
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
                        if (_formKey.currentState.validate()) {
                          print('เพิ่มห้อง');
                          Room();
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
                          controller: _num,
                          decoration: InputDecoration(
                              labelText: 'รหัสวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String value) =>
                              value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                              labelText: 'ชื่อวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String value) =>
                              value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
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

  Future<void> Sheet(m_random, m_num, m_name) async {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Navigator.of(context).pop();
                      EditRoom(m_num, m_name);
                    },
                    child: const Text(
                      'แก้ไข',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'รหัสห้อง : $m_random',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'รหัสวิชา : $m_num',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ชื่อวิชา   : $m_name',
                            style: const TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> EditRoom(m_num, m_name) async {
    TextEditingController m_num = TextEditingController();
    TextEditingController m_name = TextEditingController();
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
                        if (_formKey.currentState.validate()) {
                          print('อัปเดต');
                        }
                      },
                      child: const Text(
                        'อัปเดต',
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
                          keyboardType: TextInputType.text,
                          controller: m_num,
                          decoration: InputDecoration(
                              labelText: 'รหัสวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String value) =>
                              value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: m_name,
                          decoration: InputDecoration(
                              labelText: 'ชื่อวิชา',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (String value) =>
                              value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
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
