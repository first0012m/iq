import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = Api.Delete_My_Room;
String msg = "";

Future Delete_My_room(m_random, m_num, m_name) async {
  final prefs = await SharedPreferences.getInstance();
  http.Response Delete_My_room = await http.post(Uri.parse(baseUrl), body: {
    "m_email": await prefs.getString('token'),
    "m_random": m_random,
    "m_num": m_num,
    "m_name": m_name
  });
  var data = jsonDecode(Delete_My_room.body);
  print(data);
  return data;
}
