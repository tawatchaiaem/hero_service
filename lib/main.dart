import 'package:flutter/material.dart';
import 'package:hero_service_app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: XXX,
        initialRoute: '/welcome',
        routes: routes);
  }
}
