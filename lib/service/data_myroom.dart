import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';

String baseUrl = Api.My_Room;
String msg = "";

Future My_room() async {
  http.Response My_room = await http.post(Uri.parse(baseUrl), body: {
    "m_email": await FlutterSession().get('token'),
  });
  var data = jsonDecode(My_room.body);
  print(data);
  return data;
}
