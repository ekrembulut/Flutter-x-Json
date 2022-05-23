// To parse this JSON data, do
//
//     final posts = postsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Posts postsFromMap(String str) => Posts.fromMap(json.decode(str));

String postsToMap(Posts data) => json.encode(data.toMap());

class Posts {
    Posts({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    final int userId;
    final int id;
    final String title;
    final String body;

    factory Posts.fromMap(Map<String, dynamic> json) => Posts(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
