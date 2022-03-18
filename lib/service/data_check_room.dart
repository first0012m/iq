import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = Api.Check_Room;
String msg = "";

Future Check_room() async {
  final prefs = await SharedPreferences.getInstance();
  http.Response Check_room = await http.post(Uri.parse(baseUrl), body: {
    "m_user": await prefs.getString('token'),
  });
  var data = jsonDecode(Check_room.body);
  print(data);
  return data;
}
