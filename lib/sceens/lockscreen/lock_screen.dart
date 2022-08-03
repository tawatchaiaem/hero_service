import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/lockscreen/Numpad.dart';

class LockScreen extends StatefulWidget {
  LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  int length = 6;

  // onChange(String number) {
  //   print(number);
  //   // if (number.length == widget.length) {
  //     if (number == '123456') {
  //       print('Login sucesss');
  //       Navigator.pushReplacementNamed(context, '/dashboard');
  //     } else {
  //       _showDialog('แจ้งเตือน ', 'รหัสผ่านไม่ถูกต้อง');
  //     }
  //   // }
  // }

  void _showDialog(title, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/menu_icon/adornment.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Numpad(length: length)
          ],
        ),
      ),
    );
  }
}
