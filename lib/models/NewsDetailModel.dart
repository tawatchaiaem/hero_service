// To parse this JSON data, do
//
//     final newsDetailModel = newsDetailModelFromJson(jsonString);

import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) =>
    NewsDetailModel.fromJson(json.decode(str));

String newsDetailModelToJson(NewsDetailModel data) =>
    json.encode(data.toJson());

class NewsDetailModel {
  NewsDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : Data.fromJson(
                json["data"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.topic,
    required this.detail,
    required this.imageurl,
    required this.linkurl,
    required this.createdAt,
    required this.status,
  });

  String id;
  String topic;
  String detail;
  String imageurl;
  String linkurl;
  DateTime? createdAt;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        topic: json["topic"] == null ? null : json["topic"],
        detail: json["detail"] == null ? null : json["detail"],
        imageurl: json["imageurl"] == null ? null : json["imageurl"],
        linkurl: json["linkurl"] == null ? null : json["linkurl"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "topic": topic == null ? null : topic,
        "detail": detail == null ? null : detail,
        "imageurl": imageurl == null ? null : imageurl,
        "linkurl": linkurl == null ? null : linkurl,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "status": status == null ? null : status,
      };
}
