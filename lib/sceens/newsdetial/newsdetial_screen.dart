import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_service_app/models/NewsDetailModel.dart';
import 'package:hero_service_app/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  String? newsId;

  NewsDetailModel? _dataNews;

  readNewsDetial() async {
    var result = await Connectivity().checkConnectivity();
    print("result ${result}");
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "คุณไม่ได้เชื่อมต่อผ่านอินเตอร์เน็ต",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // try {
      var response = await CallAPI().getNewsDetail(newsId);
      print("response ${response}");
      setState(() {
        _dataNews = response;
      });
      // } catch (error) {
      //   print("error ${error}");
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    readNewsDetial();
  }

  @override
  Widget build(BuildContext context) {
    final Map argument = ModalRoute.of(context)?.settings.arguments as Map;
    print(argument['id'].toString());
    newsId = argument['id'].toString();

    print("_dataNews ${_dataNews}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${_dataNews?.data?.topic ?? "..."}'),
        ),
        body: Container(),
      ),
    );
  }
}
