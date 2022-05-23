import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_veriokuma/models/album.dart';

class JsonAlbum extends StatefulWidget {
  JsonAlbum({Key? key}) : super(key: key);

  @override
  State<JsonAlbum> createState() => _JsonAlbumState();
}

class _JsonAlbumState extends State<JsonAlbum> {
  late Future<List<Album>> myList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myList = jsonalbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album From Web"),
      ),
      body: FutureBuilder<List<Album>>(
        future: myList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var albumList = snapshot.data!;
            return ListView.builder(
              itemCount: albumList.length,
              itemBuilder: (context, index) {
                var album1 = albumList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(album1.url),
                    radius: 20,
                  ),
                  title: Text(album1.title),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Album>> jsonalbum() async {
    try {
      var myAlbum =
          await Dio().get("https://jsonplaceholder.typicode.com/photos");
      List<Album> album = [];
      if (myAlbum.statusCode == 200) {
        album = (myAlbum.data as List).map((e) => Album.fromMap(e)).toList();
      }
      return album;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
