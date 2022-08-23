import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/bottomnav/booking_screen.dart';
import 'package:hero_service_app/sceens/bottomnav/home_sreen.dart';
import 'package:hero_service_app/sceens/bottomnav/market_screnn.dart';
import 'package:hero_service_app/sceens/bottomnav/notification_screen.dart';
import 'package:hero_service_app/sceens/bottomnav/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 2;
  String _title = 'Hero services';
  late Widget _actionWidget;

  final List<Widget> _children = [
    MarketScreen(),
    BookingScreen(),
    HomeScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  // สร้าง widget action สำหรับไว้แยกแสดงผล Appbar
  Widget _homeActionBar() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/qrcode');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            Icon(Icons.center_focus_strong),
            Text('SCAN'),
          ],
        ),
      ),
    );
  }

  Widget _marketActionBar() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            Icon(Icons.add),
            Text('Add news'),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      // change title follow tab
      switch (index) {
        case 0:
          _title = 'Market';

          _actionWidget = _marketActionBar();
          break;
        case 1:
          _title = 'Booking';
          _actionWidget = Container();
          break;
        case 2:
          _title = 'Services';
          _actionWidget = _homeActionBar();
          break;
        case 3:
          _title = 'Notification';
          _actionWidget = Container();
          break;
        case 4:
          _title = 'Setting';
          _actionWidget = Container();
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _actionWidget = _homeActionBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
        actions: [_actionWidget],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.teal,
        buttonBackgroundColor: Colors.teal,
        height: 60,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        index: 2,
        items: [
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.library_books, size: 30, color: Colors.white),
          Icon(Icons.business_center, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.menu, size: 30, color: Colors.white),
        ],
        onTap: onTabTapped,
      ),
      body: _children[_currentIndex],
    );
  }
}
