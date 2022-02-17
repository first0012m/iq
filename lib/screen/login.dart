import 'package:flutter/material.dart';
import 'package:iq/home.dart';
import 'package:iq/screen/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _HomeState();
}

class _HomeState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'กรุณาชื่อผู้ใช้งาน',
                    labelText: 'ชื่อผู้ใช้',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'กรุณากรอกรหัสผ่าน',
                    labelText: 'รหัสผ่าน',
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // print('Form Complete');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false);
                    }
                  },
                  child: const Text('เข้าสู่ระบบ'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'หากยังไม่มีสมาชิก',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Regis(),
                          )); // print('สมัครสมาชิก');
                        },
                        child: const Text('สมัครสมาชิก'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
