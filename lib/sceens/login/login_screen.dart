import 'package:flutter/material.dart';
import 'package:hero_service_app/sceens/components/passwordwidget.dart';

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
}
