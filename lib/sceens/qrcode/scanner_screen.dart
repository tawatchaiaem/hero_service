import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:rxdart/rxdart.dart';

class ScannerSreen extends StatefulWidget {
  ScannerSreen({Key? key}) : super(key: key);

  @override
  State<ScannerSreen> createState() => _ScannerSreenState();
}

class _ScannerSreenState extends State<ScannerSreen> {
  // สร้าง object สำหรับเรียกตัวแสกน QR
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _flashOn = false;
  bool _frontCam = false;

  File? _image;
  String _data = '';
  String _qrcodeFile = '';
  final ImagePicker _picker = ImagePicker();

  // สร้าง method สำหรับการเลือกรูปจาก gallery
  Future getImage() async {
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = image as File?;
      Fluttertoast.showToast(
        msg: _image.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    String filename = '1559788943.png';
    // Observable.fromFuture(getTemporaryDirectory())
    //     .flatMap((tempDir) {
    //       File qrCodeFile = File('${tempDir.path}/$filename');
    //       bool exists = qrCodeFile.existsSync();
    //       if (exists) {
    //         return Observable.just(qrCodeFile);
    //       } else {
    //         return Observable.fromFuture(
    //                 rootBundle.load("assets/images/$filename"))
    //             .flatMap((bytes) => Observable.fromFuture(
    //                 qrCodeFile.writeAsBytes(bytes.buffer.asUint8List(
    //                     bytes.offsetInBytes, bytes.lengthInBytes))));
    //       }
    //     })
    //     .flatMap((file) =>
    //         Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path)))
    //     .listen((data) {
    //       setState(() {
    //         _data = data;
    //       });
    //     });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Container(
      child: Stack(
        children: [
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderLength: 15.0,
                borderWidth: 5.0,
                borderRadius: 2.0),
            onQRViewCreated: (QRViewController controller) {
              this.controller = controller;
              controller.scannedDataStream.listen((scanData) {
                print(scanData);
                if (mounted) {
                  Fluttertoast.showToast(
                      msg: scanData.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  controller.dispose();
                  // ปิดหน้า scan
                  Navigator.pop(context);
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Text(
                'วางคิวอาร์โค้ดให้อยู่ในกรอบเพื่อสแกน',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 80.0),
              child: OutlinedButton(
                onPressed: getImage,
                child: Text(
                  'นำเข้าจากแกเลอรี่',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    shape: StadiumBorder()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                    onPressed: () {
                      setState(() {
                        _flashOn = !_flashOn;
                        controller?.toggleFlash();
                      });
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(
                        _frontCam ? Icons.camera_front : Icons.camera_rear),
                    onPressed: () {
                      setState(() {
                        _frontCam = !_frontCam;
                        controller?.flipCamera();
                      });
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _getPhotoByGallery() {
    // Observable.fromFuture(_picker.pickImage(
    //   source: ImageSource.gallery,
    // )).flatMap((file) {
    //   setState(() {
    //     _qrcodeFile = file.path;
    //   });
    //   return Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path));
    // }).listen((data) {
    //   setState(() {
    //     _data = data;
    //     Fluttertoast.showToast(
    //         msg: _data.toString(),
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.green,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   });
    // }).onError((error, stackTrace) {
    //   setState(() {
    //     _data = '';
    //   });
    //   print('${error.toString()}');
    // });
  }
}
