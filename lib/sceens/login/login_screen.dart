import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_service_app/sceens/components/passwordwidget.dart';
import 'package:hero_service_app/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _password;
  // final String? email;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    // initialValue: 'test@gmail.com',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value) {
                      setState(() {
                        this._email = value;
                      });
                    },
                    onSaved: (value) {
                      this._email = value?.trim();
                    }),
                PasswordField(
                  helperText: 'No more than 6 digits',
                  labelText: 'Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length != 6) {
                      return 'No more than 6 digits';
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._password = value;
                    });
                  },
                  onSaved: (value) {
                    this._password = value?.trim();
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('Vaaaaaaalll ');
                      print(formKey.currentState);
                      formKey.currentState!.save();
                      print(_email);
                      print(_password);
                      var userData = {'email': _email, 'password': _password};
                      _loginProcess(userData);
                    }
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginProcess(userData) async {
    try {
      var response = await CallAPI().loginAPI(userData);
      print(response);
      var body = json.decode(response.body);

      if (body['status'] == 'success' && body['data']['status'] == '1') {
        // สร้าง Object แบบ SharedPreferences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setInt('appStep', 2);
        sharedPreferences.setString('storeFullname',
            body['data']['firstname'] + body['data']['lastname']);
        sharedPreferences.setString('storeAvatar', body['data']['avatar']);
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showDialog('ข้อมูลผิดพลาด', 'ข้อมูลไม่ถูกต้อง ลอง');
      }
      print(body['message']);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "มีข้อผิดพลาดการโหลดข้อมูล",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _showDialog(title, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
