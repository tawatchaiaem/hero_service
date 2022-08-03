import 'package:flutter/material.dart';

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
            onPressed: () {
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
