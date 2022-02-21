// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iq/api.dart';
import 'package:http/http.dart' as http;

class Regis extends StatefulWidget {
  const Regis({Key? key}) : super(key: key);

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _m_username = TextEditingController();
  final TextEditingController _m_password = TextEditingController();
  final TextEditingController _m_passwordHid = TextEditingController();
  final TextEditingController _m_name = TextEditingController();
  final TextEditingController _m_lastname = TextEditingController();
  final TextEditingController _m_email = TextEditingController();
  final TextEditingController _m_phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String baseUrl = Api.Reg;
  String msg = "";

  Reg() async {
    var Reg = await http.post(Uri.parse(baseUrl), body: {
      "m_id": _id.text,
      "m_username": _m_username.text,
      "m_password": _m_password.text,
      "m_passwordHid": _m_passwordHid.text,
      "m_name": _m_name.text,
      "m_lastname": _m_lastname.text,
      "m_email": _m_email.text,
      "m_phone": _m_phone.text,
    });
    var data = jsonDecode(Reg.body);
    print(data);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _id,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.format_list_numbered),
                    hintText: 'กรุณากรอก ID',
                    labelText: 'ID',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _m_username,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอกชื่อผู้ใช้',
                    labelText: 'ชื่อผู้ใช้',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  controller: _m_password,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'กรุณากรอกรหัสผ่าน',
                    labelText: 'รหัสผ่าน',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  controller: _m_passwordHid,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password_sharp),
                    hintText: 'กรุณากรอกรหัสผ่านอีกครั้ง',
                    labelText: 'ยืนยันรหัสผ่าน',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _m_name,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.ac_unit_sharp),
                    hintText: 'กรุณากรอกชื่อ',
                    labelText: 'ชื่อ',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _m_lastname,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'กรุณากรอกนามสกุล',
                    labelText: 'นามสกุล',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _m_email,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'กรุณากรอก E-mail',
                    labelText: 'E-mail',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _m_phone,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: 'กรุณากรอกเบอร์โทรศัพท์',
                    labelText: 'เบอร์โทรศัพท์',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Reg();
                      //print('สมัครสมาชิก');
                    }
                  },
                  child: const Text('สมัครสมาชิก'),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
