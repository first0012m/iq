import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';

String baseUrl = Api.Delete_My_Room;
String msg = "";

Future Delete_My_room(m_random, m_num, m_name) async {
  http.Response Delete_My_room = await http.post(Uri.parse(baseUrl), body: {
    "m_email": await FlutterSession().get('token'),
    "m_random": m_random,
    "m_num": m_num,
    "m_name": m_name
  });
  var data = jsonDecode(Delete_My_room.body);
  print(data);
  return data;
}
