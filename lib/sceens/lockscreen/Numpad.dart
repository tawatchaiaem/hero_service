import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // แสกนนิ้ว

class Numpad extends StatefulWidget {
  final int length;
  // final Function onChange;

  Numpad({Key? key, required this.length}) : super(key: key);

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  String number = '';

  setValue(String val) async {
    print('val ' + val);
    if (number.length < widget.length) {
      setState(() {
        number += val;
        print('number ' + number);
        // widget.onChange(number);
      });
    }

    if (number.length == widget.length) {
      if (number == '123456') {
        // สร้าง Object แบบ SharedPreferences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('appStep', 2);

        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        number = '';
      }
    }
  }

  backspace(String text) {
    if (text.length > 0) {
      setState(() {
        number = text.split('').sublist(0, text.length - 1).join('');
        // widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Preview(text: number, length: widget.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: () => setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: () => setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: () => setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: () => setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: () => setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: () => setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: () => setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: () => setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: () => setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumpadButton(
                haveBorder: false,
                icon: Icons.fingerprint,
                onPressed: () async {
                  // final authSuccess = await this._auth();
                  // setState(() => this._authSuccess = authSuccess);
                },
              ),
              NumpadButton(
                text: '0',
                onPressed: () => setValue('0'),
              ),
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: () => backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool? haveBorder;
  final Function? onPressed;
  NumpadButton(
      {Key? key, this.text, this.icon, this.haveBorder = true, this.onPressed})
      : super(key: key);
  callMethod() {
    if (onPressed != null) {
      onPressed!(); //Note: ! is added here
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(fontSize: 30.0, color: Colors.black);
    Widget label = icon != null
        ? Icon(
            icon,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            size: 40.0,
          )
        : Text('${this.text}', style: buttonStyle);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      // child: OutlinedButton(
      //   style: OutlinedButton.styleFrom(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10.0),
      //     ),
      //     side: BorderSide(width: 1, color: Colors.green),
      //   ),
      //   onPressed: callMethod,
      //   child: label,
      // ),
      child: ElevatedButton(
        onPressed: callMethod,
        child: label,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24),
          primary: Colors.white,
        ),
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final int? length;
  final String? text;
  const Preview({Key? key, this.length, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];
    for (var i = 0; i < length!.toInt(); i++) {
      previewLength.add(Dot(isActive: text!.length >= i + 1));
    }
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(children: previewLength));
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(width: 1.0, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
