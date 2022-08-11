import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_service_app/models/LoginModel.dart';
import 'package:hero_service_app/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  LoginModel? _dataProfile;

  String? birthDate;

  readUserProfile() async {
    // Check internet connection
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "มีข้อผิดพลาดการโหลดข้อมูล",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      var userData = {
        'email': sharedPreferences.getString('storeEmail').toString(),
        'password': sharedPreferences.getString('storePassword').toString()
      };
      try {
        var response = await CallAPI().getProfile(userData);
        print(sharedPreferences.getString('storeEmaile'));
        print(userData);
        print(_dataProfile?.data?.birthdate.toString());
        // _dataProfile = response;
        setState(() {
          _dataProfile = response;

          birthDate = DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(_dataProfile!.data!.birthdate.toString()));
        });
        print(_dataProfile);
        // print(_dataProfile?.data?.firstname);
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    print(_dataProfile?.data?.firstname);
    return Scaffold(
      appBar: AppBar(title: Text('ข้อมูลผู้ใช้')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('${_dataProfile?.data?.firstname ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสผู้ใช้'),
            subtitle: Text('${_dataProfile?.data?.empid ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('เพศ'),
            subtitle: Text('${_dataProfile?.data?.gender ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('${_dataProfile?.data?.position ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('${_dataProfile?.data?.department ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('${birthDate ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('${_dataProfile?.data?.salary ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล'),
            subtitle: Text('${_dataProfile?.data?.email ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('โทรศัพท์'),
            subtitle: Text('${_dataProfile?.data?.tel ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('${_dataProfile?.data?.address ?? "..."}'),
          ),
        ],
      ),
    );
  }
}
