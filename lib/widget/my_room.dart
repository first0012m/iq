import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iq/api.dart';
import 'package:iq/service/data_dalete_myroom.dart';
import 'package:iq/service/data_myroom.dart';
import 'package:http/http.dart' as http;

class MyRoom extends StatefulWidget {
  const MyRoom({Key? key}) : super(key: key);

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
  late List list;
  late String m_random;
  late String m_num;
  late String m_name;

  Randoms() async {
    random = rng.nextInt(100000);
    print(random);
  }

  Room() async {
    var room = await http.post(Uri.parse(baseUrl), body: {
      "m_random": random.toString(),
      "m_num": _num.text,
      "m_name": _name.text,
      "m_ajname": await FlutterSession().get('token')
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
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        Delete_My_room(list[index]['m_random'],
                            list[index]['m_num'], list[index]['m_name']);
                      });
                    },
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
            body: Center(
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
                        if (_formKey.currentState!.validate()) {
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
                          validator: (String? value) =>
                              value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
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
