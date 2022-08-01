import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/bottomnav/booking_screen.dart';
import 'package:hero_service_app/sceens/bottomnav/home_sreen.dart';
import 'package:hero_service_app/sceens/bottomnav/market_screnn.dart';
import 'package:hero_service_app/sceens/bottomnav/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String _title = 'Hero services';

  final List<Widget> _children = [
    HomeScreen(),
    MarketScreen(),
    BookingScreen(),
    SettingScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      // change title follow tab
      switch (index) {
        case 0:
          _title = 'services';
          break;
        case 1:
          _title = 'market';
          break;
        case 2:
          _title = 'booking';
          break;
        case 3:
          _title = 'setting';
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 248, 194, 194),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business_center,
              color: Colors.white,
            ),
            label: 'บริการ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: 'ตลาด',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            label: 'รายการจอง',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            label: 'setting',
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
