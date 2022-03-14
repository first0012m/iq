import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iq/api.dart';

String baseUrl = Api.Home;
String msg = "";

Future home(Snapname) async {
  http.Response Home = await http.post(Uri.parse(baseUrl), body: {
    "m_email": Snapname,
  });
  var data = jsonDecode(Home.body);
  //return List.from(data.map((str) => ListData.fromJson(str)));
  return data;
}
