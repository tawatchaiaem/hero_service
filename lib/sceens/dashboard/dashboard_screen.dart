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

  final List<Widget> _children = [
    MarketScreen(),
    BookingScreen(),
    HomeScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      // change title follow tab
      switch (index) {
        case 0:
          _title = 'Market';
          break;
        case 1:
          _title = 'Booking';
          break;
        case 2:
          _title = 'Services';
          break;
        case 3:
          _title = 'Notification';
          break;
        case 4:
          _title = 'Setting';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('$_title')),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabTapped,
      //   currentIndex: _currentIndex,
      //   backgroundColor: Colors.red,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Color.fromARGB(255, 248, 194, 194),
      //   unselectedItemColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.business_center,
      //         color: Colors.white,
      //       ),
      //       label: 'บริการ',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.shopping_cart,
      //         color: Colors.white,
      //       ),
      //       label: 'ตลาด',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.library_books,
      //         color: Colors.white,
      //       ),
      //       label: 'รายการจอง',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.menu,
      //         color: Colors.white,
      //       ),
      //       label: 'setting',
      //     )
      //   ],
      // ),
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
