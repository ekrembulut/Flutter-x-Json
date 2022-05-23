// To parse this JSON data, do
//
//     final album = albumFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Album albumFromMap(String str) => Album.fromMap(json.decode(str));

String albumToMap(Album data) => json.encode(data.toMap());

class Album {
    Album({
        required this.albumId,
        required this.id,
        required this.title,
        required this.url,
        required this.thumbnailUrl,
    });

    final int albumId;
    final int id;
    final String title;
    final String url;
    final String thumbnailUrl;

    factory Album.fromMap(Map<String, dynamic> json) => Album(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toMap() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };
}
