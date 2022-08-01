import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/dashboard/dashboard_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/dashboard": (BuildContext context) => DashboardScreen()
};
