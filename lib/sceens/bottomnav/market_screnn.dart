import 'package:flutter/material.dart';
import 'package:hero_service_app/models/NewsModel.dart';
import 'package:hero_service_app/services/rest_api.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
            child: Text(
              'ข่าวประกาศล่าสุด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder(
              future: CallAPI().getNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel?>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error  ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel?>? news = snapshot.data;
                  return _listViewNews(news!);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // สร้าง ListView สำหรับการแสดงข่าว
  Widget _listViewNews(List<NewsModel?> news) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        // Load model
        NewsModel newsModel = news[index]!;
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.4,
          child: InkWell(
            onTap: () {
              print("TESTEST ");
            },
            child: Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 125.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(newsModel.imageurl),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            newsModel.topic,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            newsModel.detail,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
