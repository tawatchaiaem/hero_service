import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/qrcode/mycode_screen.dart';
import 'package:hero_service_app/sceens/qrcode/scanner_screen.dart';

class QRCodeScreen extends StatefulWidget {
  QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  // กดเกดเดก
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คิวอาร์โค้ด'),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'ตัวสแกน'),
            Tab(text: 'โค้ดของฉัน'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          ScannerSreen(),
          MyCodeScreen(),
        ],
      ),
    );
  }
}
