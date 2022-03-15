import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';

String baseUrl = Api.Delete_Check_Room;
String msg = "";

Future Delete_Check_Room(m_random, m_num, m_name, m_ajname) async {
  http.Response Delete_Check_Room = await http.post(Uri.parse(baseUrl), body: {
      "m_random": m_random,
      "m_num": m_num,
      "m_name": m_name,
      "m_user": await FlutterSession().get('token'),
      "m_ajname": m_ajname,
  });
  var data = jsonDecode(Delete_Check_Room.body);
  print(data);
  return data;
}
