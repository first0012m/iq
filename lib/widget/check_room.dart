import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iq/api.dart';
import 'package:iq/service/data_check_room.dart';
import 'package:iq/service/data_delete_checkroom.dart';

class CheckRoom extends StatefulWidget {
  const CheckRoom({Key? key}) : super(key: key);

  @override
  State<CheckRoom> createState() => _CheckRoomState();
}

class _CheckRoomState extends State<CheckRoom> {
  final TextEditingController _num = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String baseUrl = Api.Add_Check_Room;
  String baseUrljoin = Api.Join_Room;
  late List list;
  var data;

  AddCheckRoom() async {
    var AddCheckRoom = await http.post(Uri.parse(baseUrl), body: {
      "m_num": _num.text,
    });
    data = jsonDecode(AddCheckRoom.body);
    _num.clear();
    print(data);

    Navigator.of(context).pop();
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ห้องที่ค้นหา"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('รหัสห้อง : ${data['m_random']}'),
                Text('รหัสวิชา : ${data['m_num']}'),
                Text('ชื่อวิชา : ${data['m_name']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                JoinRoom(data['m_random'], data['m_num'], data['m_name'],
                    data['m_ajname']);
              },
              child: const Text('เข้าร่วม'),
            ),
          ],
        );
      },
    );
  }

  JoinRoom(m_random, m_num, m_name, m_ajname) async {
    var JoinRoom = await http.post(Uri.parse(baseUrljoin), body: {
      "m_random": m_random,
      "m_num": m_num,
      "m_name": m_name,
      "m_user": await FlutterSession().get('token'),
      "m_ajname": m_ajname,
    });
    var joindata = jsonDecode(JoinRoom.body);
    print(joindata);

    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Check_room(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                list = snapshot.data;
                return ListTile(
                  title: Text('${list[index]['m_num']} ${list[index]['m_name']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Delete_Check_Room(list[index]['m_random'], list[index]['m_num'], list[index]['m_name'], list[index]['m_ajname']);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                          },
                          icon: const Icon(Icons.more_vert)),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addCheckRoom();
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
                addCheckRoom();
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

  Future<void> addCheckRoom() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: const Text("กรุณากรอกรหัสห้อง"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                    controller: _num,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) =>
                        value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('ยกเลิก'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AddCheckRoom();
                    //print('สมัครสมาชิก');
                  }
                },
                child: const Text('ค้นหา'),
              ),
            ],
          ),
        );
      },
    );
  }
}
