import 'package:flutter/material.dart';
import 'package:hero_service_app/models/NEwsDetailModel.dart';
import 'package:hero_service_app/sceens/dashboard/dashboard_screen.dart';
import 'package:hero_service_app/sceens/lockscreen/lock_screen.dart';
import 'package:hero_service_app/sceens/login/login_screen.dart';
import 'package:hero_service_app/sceens/newsdetial/newsdetial_screen.dart';
import 'package:hero_service_app/sceens/qrcode/qrcode_screen.dart';
import 'package:hero_service_app/sceens/userprofile/userprofile_screen.dart';
import 'package:hero_service_app/sceens/welcome/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/userprofile": (BuildContext context) => UserProfileScreen(),
  "/newsdetail": (BuildContext context) => NewsDetailScreen(),
  "/qrcode": (BuildContext context) => QRCodeScreen(),
};
