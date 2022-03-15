import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';

String baseUrl = Api.Check_Room;
String msg = "";

Future Check_room() async {
  http.Response Check_room = await http.post(Uri.parse(baseUrl), body: {
    "m_user": await FlutterSession().get('token'),
  });
  var data = jsonDecode(Check_room.body);
  print(data);
  return data;
}
