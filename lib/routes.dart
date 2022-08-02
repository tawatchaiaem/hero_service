import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/dashboard/dashboard_screen.dart';
import 'package:hero_service_app/sceens/welcome/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen()
};
