import 'package:flutter/material.dart';

class Regis extends StatefulWidget {
  const Regis({Key? key}) : super(key: key);

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  final _formKey = GlobalKey<FormState>();

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
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอก ID',
                    labelText: 'ID',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอกชื่อผู้ใช้',
                    labelText: 'ชื่อผู้ใช้',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอกชื่อ',
                    labelText: 'ชื่อ',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอกนามสกุล',
                    labelText: 'นามสกุล',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอก E-mail',
                    labelText: 'E-mail',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณากรอกเบอร์โทรศัพท์',
                    labelText: 'เบอร์โทรศัพท์',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
