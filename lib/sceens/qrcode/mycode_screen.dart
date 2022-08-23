import 'package:flutter/material.dart';

class MyCodeScreen extends StatefulWidget {
  MyCodeScreen({Key? key}) : super(key: key);

  @override
  State<MyCodeScreen> createState() => _MyCodeScreenState();
}

class _MyCodeScreenState extends State<MyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('My code screen'),
    );
  }
}
