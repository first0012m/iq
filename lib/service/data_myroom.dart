import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = Api.My_Room;
String msg = "";

Future My_room() async {
  final prefs = await SharedPreferences.getInstance();
  http.Response My_room = await http.post(Uri.parse(baseUrl), body: {
    "m_email": await prefs.getString('token')
  });
  var data = jsonDecode(My_room.body);
  print(data);
  return data;
}
