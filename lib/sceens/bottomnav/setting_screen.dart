import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          ElevatedButton(
            onPressed: () async {
              // สร้าง Object แบบ SharedPreferences
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              sharedPreferences.setInt('appStep', 3);

              Navigator.pushReplacementNamed(context, '/lockscreen');
            },
            child: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
