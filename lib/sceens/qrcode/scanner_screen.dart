import 'package:flutter/material.dart';

class ScannerSreen extends StatefulWidget {
  ScannerSreen({Key? key}) : super(key: key);

  @override
  State<ScannerSreen> createState() => _ScannerSreenState();
}

class _ScannerSreenState extends State<ScannerSreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'วางคิวอาร์โค้ดให้อยู่ในกรอบเพื่อสแกน',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
